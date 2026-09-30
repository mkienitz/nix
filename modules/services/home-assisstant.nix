{ inputs, ... }:
{
  flake.modules.nixos.home-assistant =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      homeAssistantDomain = "home.maxkienitz.com";
      flakeLib = inputs.self.lib;
      lanInterface = "enp1s0";
      threadInterface = "wpan0";
    in
    {
      imports = [
        inputs.self.modules.nixos.acme-maxkienitz-com
      ];

      config = lib.mkMerge [
        (flakeLib.mkAcmeCert homeAssistantDomain)
        (flakeLib.mkAcmeStatePersistence homeAssistantDomain)
        {
          networking.firewall = {
            filterForward = true;
            extraForwardRules = ''
              iifname "${lanInterface}" oifname "${threadInterface}" meta nfproto ipv6 accept
              iifname "${threadInterface}" oifname "${lanInterface}" meta nfproto ipv6 accept
            '';
            # Matter uses dynamic ports; allow Thread device traffic even after
            # conntrack entries expire between reports from sleepy sensors.
            extraInputRules = ''
              iifname "${threadInterface}" meta nfproto ipv6 meta l4proto { tcp, udp } accept
            '';
            allowedTCPPorts = [
              # UPNP-HTTP
              40000
            ];
            allowedTCPPortRanges = [
              # HomeKit 🤢
              {
                from = 21063;
                to = 21065;
              }
            ];
            allowedUDPPorts = [
              # SSDP & UPNP
              1900
              # mDNS
              5353
            ];
          };

          environment.persistence = {
            "/persist".directories = [
              {
                directory = config.services.home-assistant.configDir;
                user = "hass";
                group = "hass";
                mode = "0700";
              }
              {
                directory = "/var/lib/thread";
                user = "root";
                group = "otbr";
                mode = "0700";
              }
              {
                # Persist the backing directory; systemd manages DynamicUser ownership.
                directory = "/var/lib/private/matterjs-server";
                mode = "0700";
              }
            ];
          };

          # Impermanence creates parent directories with mode 0755 and copies
          # their persisted permissions back at boot. DynamicUser requires 0700.
          systemd.tmpfiles.rules = [
            "d /persist/var/lib/private 0700 root root -"
            "d /var/lib/private 0700 root root -"
          ];

          services.home-assistant = {
            enable = true;
            extraComponents = [
              "zha"
              # The STYRBAR blueprint declares MQTT device triggers even when using ZHA.
              "mqtt"
              "radio_browser"
              "met"
              "homekit"
              "thread"
              "otbr"
              "matter"
            ];
            config = {
              default_config = { };
              homeAssistant = {
                name = "Home";
                unit_system = "metric";
              };
              # HTTP settings were migrated to persistent storage in HA 2026.8.
              # Manage them under Settings > System > Network > HTTP server.
              logger = {
                default = "warning";
              };
              "automation" = "!include automations.yaml";
            };
            extraPackages =
              python3Packages: with python3Packages; [
                # bloaty import errors 😡
                aioairzone
                aiohomekit
                fritzconnection
                pyfritzhome
                getmac
                pyatv
                python-otbr-api
                pyipp
                pytradfri

                # For some protocols
                zlib-ng
                gtts

                # dwdwfsapi
                # Weird Postrges thing
                # psycopg2
                # pymiele
                # pymodbus
              ];
            blueprints.automation = [
              (pkgs.fetchurl {
                url = "https://raw.githubusercontent.com/EPMatt/awesome-ha-blueprints/refs/heads/main/blueprints/controllers/ikea_e2001_e2002/ikea_e2001_e2002.yaml";
                hash = "sha256-z/Id3z6K8P2v42Bg7vfQ4SdFFxeBqwm8UCAkRANGO5o=";
              })
              (pkgs.fetchurl {
                url = "https://raw.githubusercontent.com/EPMatt/awesome-ha-blueprints/refs/heads/main/blueprints/hooks/light/light.yaml";
                hash = "sha256-C2AHy5RYjoM4RtYVX51G+eTRfrTeN5AJBgkkQDu46SQ=";
              })
            ];
          };

          services.openthread-border-router = {
            enable = true;
            backboneInterfaces = [ lanInterface ];
            interfaceName = threadInterface;
            # SL-OPENTHREAD/2.7.2.0_GitHub-fb0446f53
            radio = {
              device = "/dev/serial/by-id/usb-SONOFF_SONOFF_Dongle_Plus_MG24_bedd4cf6eaf8ef11bd416d135c2a50c9-if00-port0";
              baudRate = 460800;
              flowControl = false;
            };
            rest = {
              listenAddress = "127.0.0.1";
              listenPort = 8081;
            };
            web.enable = false;
            openFirewall = false;
          };

          services.matterjs-server = {
            enable = true;
            listenAddress = "127.0.0.1";
            port = 5580;
            openFirewall = false;
            # Commission devices using the phone's Companion app and Bluetooth.
            bluetoothSupport = false;
            extraArgs = [ "--primary-interface=${lanInterface}" ];
          };

          services.avahi = {
            enable = true;
            ipv4 = true;
            ipv6 = true;
            nssmdns4 = true;
            nssmdns6 = true;
            publish = {
              enable = true;
              addresses = true;
            };
          };

          services.nginx = flakeLib.mkNginxProxy {
            name = "home-assistant";
            domain = homeAssistantDomain;
            # Match the HTTP server settings in Home Assistant's UI, with
            # Trust X-Forwarded-For enabled and 127.0.0.1 as a trusted proxy.
            address = "127.0.0.1";
            port = 8123;
          };
        }
      ];
    };
}

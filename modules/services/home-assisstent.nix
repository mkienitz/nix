{ inputs, ... }:
{
  flake.modules.nixos.home-assistant =
    {
      config,
      pkgs,
      ...
    }:

    let
      homeAssistantDomain = "home.maxkienitz.com";
    in
    {
      imports = [
        inputs.self.modules.nixos.acme-maxkienitz-com
      ];

      security.acme.certs.${homeAssistantDomain}.inheritDefaults = true;

      networking.firewall = {
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

      environment.persistence."/persist".directories = [
        {
          directory = config.services.home-assistant.configDir;
          user = "hass";
          group = "hass";
          mode = "0700";
        }
      ];

      services.home-assistant = {
        enable = true;
        extraComponents = [
          "zha"
          "radio_browser"
          "met"
          "homekit"
        ];
        config = {
          default_config = { };
          homeAssistant = {
            name = "Home";
            unit_system = "metric";
          };
          http = {
            server_host = "127.0.0.1";
            server_port = 8123;
          };
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

      services.nginx = {
        upstreams.home-assistant =
          let
            inherit (config.services.home-assistant.config.http) server_host server_port;
          in
          {
            servers."${server_host}:${toString server_port}" = { };
            extraConfig = ''
              zone home-assistant 64k;
              keepalive 5;
            '';
          };
        virtualHosts.${homeAssistantDomain} = {
          forceSSL = true;
          useACMEHost = homeAssistantDomain;
          locations."/" = {
            proxyPass = "http://home-assistant";
            proxyWebsockets = true;
          };
        };
      };

    };
}

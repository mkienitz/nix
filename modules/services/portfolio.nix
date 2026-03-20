{ inputs, ... }:
{
  flake.modules.nixos.portfolio =
    {
      config,
      pkgs,
      ...
    }:
    let
      lrsyncDomain = "lrsync.maxkienitz.com";
    in
    {
      imports = [
        inputs.lrsync.nixosModules.default
        inputs.portfolio.nixosModules.default
      ];

      environment.systemPackages = [
        (pkgs.symlinkJoin {
          name = "lrsync-tui-wrapped";
          paths = [ inputs.lrsync.packages."${pkgs.stdenv.hostPlatform.system}".lrsync-tui ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/lrsync-tui \
            --add-flags "--remote" \
            --add-flags "${config.services.lrsync.address}:${toString config.services.lrsync.port}"
          '';
        })
      ];

      networking.firewall.allowedTCPPorts = [ config.services.lrsync.port ];

      age.secrets = {
        lrsync-client-id = {
          rekeyFile = inputs.secrets + "/lrsync-client-id.age";
          group = "lrsync";
          mode = "440";
        };
        lrsync-client-secret = {
          rekeyFile = inputs.secrets + "/lrsync-client-secret.age";
          group = "lrsync";
          mode = "440";
        };
        lrsync-encryption-key = {
          rekeyFile = inputs.secrets + "/lrsync-encryption-key.age";
          group = "lrsync";
          mode = "440";
        };
      };

      services.lrsync = {
        enable = true;
        address = "127.0.0.1";
        port = 10002;
        encryptionKeyFile = config.age.secrets.lrsync-encryption-key.path;
        adobe = {
          clientIdFile = config.age.secrets.lrsync-client-id.path;
          clientSecretFile = config.age.secrets.lrsync-client-secret.path;
        };
      };

      services.portfolio = {
        enable = true;
        address = "127.0.0.1";
        port = 10003;
        cfCdnZone = "maxkienitz.com";
        lrsync = {
          imagesUrl = "https://${lrsyncDomain}/images";
          address = "http://${config.services.lrsync.address}";
          inherit (config.services.lrsync) port;
        };
      };

      # So nginx can serve the images directory
      users.users.nginx.extraGroups = [ "lrsync" ];

      services.nginx = {
        virtualHosts =
          let
            defaults = {
              forceSSL = true;
              enableACME = true;
            };
          in
          {
            "portfolio.maxkienitz.com" = defaults // {
              locations."/" = {
                proxyPass =
                  let
                    inherit (config.services.portfolio) address port;
                  in
                  "http://${address}:${toString port}";
              };
            };
            "${lrsyncDomain}" = defaults // {
              locations = {
                "/" = {
                  return = "404";
                };
                "/auth/callback" = {
                  proxyPass =
                    let
                      inherit (config.services.lrsync) address port;
                    in
                    "http://${address}:${toString port}/auth/callback";
                  extraConfig = ''
                    client_max_body_size 500M;
                  '';
                };
                "^~ /images/" = {
                  alias = "/var/lib/lrsync/images/";
                  extraConfig = ''
                    disable_symlinks on;
                    if ($uri !~* \.png$) {
                      return 404;
                    }
                  '';
                };
              };
            };
          };
      };
    };
}

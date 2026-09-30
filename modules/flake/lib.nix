{
  inputs,
  lib,
  withSystem,
  ...
}:
{
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.lib = rec {
    mkNixosHost =
      hostName: arch:
      (withSystem arch (
        { pkgs, ... }:
        {
          ${hostName} = inputs.nixpkgs.lib.nixosSystem {
            modules = [
              inputs.self.modules.nixos.${hostName}
              {
                networking.hostName = hostName;
                nixpkgs = {
                  hostPlatform = arch;
                  inherit (pkgs) overlays config;
                };
              }
            ];
          };
        }
      ));

    mkDarwinHost =
      hostName: arch:
      (withSystem arch (
        { pkgs, ... }:
        {
          ${hostName} = inputs.nix-darwin.lib.darwinSystem {
            modules = [
              inputs.self.modules.darwin.${hostName}
              {
                networking = {
                  inherit hostName;
                  computerName = hostName;
                };
                nixpkgs = {
                  hostPlatform = arch;
                  inherit (pkgs) overlays config;
                };
              }
            ];
          };
        }
      ));

    mkNginxUpstream =
      {
        name,
        address,
        port,
        zoneSize ? "64k",
        keepalive ? 5,
      }:
      {
        ${name} = {
          servers."${address}:${toString port}" = { };
          extraConfig = ''
            zone ${name} ${zoneSize};
            keepalive ${toString keepalive};
          '';
        };
      };

    mkNginxProxy =
      {
        name,
        domain,
        address,
        port,
        acmeHost ? domain,
        enableACME ? null,
        forceSSL ? true,
        proxyWebsockets ? true,
        virtualHost ? { },
        location ? { },
      }:
      {
        upstreams = mkNginxUpstream {
          inherit
            name
            address
            port
            ;
        };
        virtualHosts.${domain} =
          lib.optionalAttrs (enableACME != null) { inherit enableACME; }
          // lib.optionalAttrs (acmeHost != null) { useACMEHost = acmeHost; }
          // {
            inherit forceSSL;
            locations."/" = {
              proxyPass = "http://${name}";
              inherit proxyWebsockets;
            }
            // location;
          }
          // virtualHost;
      };

    mkAcmeCert = domain: {
      security.acme.certs.${domain}.inheritDefaults = true;
    };

    mkAcmeStatePersistence = domain: {
      environment.persistence."/state".directories = [ "/var/lib/acme/${domain}" ];
    };
  };
}

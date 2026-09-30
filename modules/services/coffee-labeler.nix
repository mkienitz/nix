{ inputs, ... }:
{
  flake.modules.nixos.coffee-labeler =
    let
      coffee-labeler-domain = "label.maxkienitz.com";
      flakeLib = inputs.self.lib;
    in
    { config, lib, ... }:
    {
      imports = [
        inputs.coffee-labeler.nixosModules.default
        inputs.self.modules.nixos.acme-maxkienitz-com
      ];

      config = lib.mkMerge [
        (flakeLib.mkAcmeCert coffee-labeler-domain)
        {
          services.coffee-labeler = {
            enable = true;
            address = "127.0.0.1";
            port = 10000;
            printer-address = "192.168.178.39";
            printer-port = 9100;
          };

          services.nginx =
            let
              inherit (config.services.coffee-labeler) address port;
            in
            flakeLib.mkNginxProxy {
              name = "coffee-labeler";
              domain = coffee-labeler-domain;
              inherit address port;
              location = {
                extraConfig = ''
                  proxy_set_header X-Real-IP $remote_addr;
                  proxy_set_header X-Forwarded-Host $host;
                  proxy_set_header X-Forwarded-Proto $scheme;
                '';
              };
            };
        }
      ];
    };
}

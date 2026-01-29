{ inputs, ... }:
{
  flake.modules.nixos.bipper =
    { config, ... }:
    {
      imports = [
        inputs.bipper.nixosModules.default
      ];

      services.bipper = {
        enable = true;
        address = "127.0.0.1";
        port = 3939;
        storageDuration = "1h";
      };

      services.nginx = {
        virtualHosts =
          let
            defaults = {
              forceSSL = true;
              enableACME = true;
            };
          in
          {
            "bipper.maxkienitz.com" = defaults // {
              locations."/" = {
                proxyPass =
                  let
                    inherit (config.services.bipper) address port;
                  in
                  "http://${address}:${toString port}/";
                extraConfig = ''
                  client_max_body_size 500M;
                '';
              };
            };
          };
      };
    };
}

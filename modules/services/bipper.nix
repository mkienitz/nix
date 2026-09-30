{ inputs, ... }:
{
  flake.modules.nixos.bipper =
    { config, ... }:
    let
      flakeLib = inputs.self.lib;
    in
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

      services.nginx =
        let
          inherit (config.services.bipper) address port;
        in
        flakeLib.mkNginxProxy {
          name = "bipper";
          domain = "bipper.maxkienitz.com";
          inherit address port;
          acmeHost = null;
          enableACME = true;
          location = {
            proxyPass = "http://bipper/";
            extraConfig = ''
              client_max_body_size 500M;
            '';
          };
        };
    };
}

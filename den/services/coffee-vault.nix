{ inputs, ... }:
{
  flake.modules.nixos.coffee-vault =
    {
      config,
      ...
    }:
    let
      coffeeVaultDomain = "coffee.maxkienitz.com";
    in
    {
      imports = [
        inputs.coffee-vault.nixosModules.default
        inputs.self.modules.nixos.acme-maxkienitz-com
      ];
      security.acme.certs.${coffeeVaultDomain}.inheritDefaults = true;

      environment.persistence = {
        "/state".directories = [
          "/var/lib/acme/${coffeeVaultDomain}"
        ];
        "/persist".directories = [
          {
            directory = config.services.coffee-vault.workingDirectory;
            user = "coffee-vault";
            group = "coffee-vault";
            mode = "0750";
          }
        ];
      };

      services = {
        coffee-vault = {
          enable = true;
          port = 33333;
          domain = coffeeVaultDomain;
        };
        nginx = {
          upstreams.coffee-vault =
            let
              inherit (config.services.coffee-vault) address port;
            in
            {
              servers."${address}:${builtins.toString port}" = { };
              extraConfig = ''
                zone coffee-vault 64k;
                keepalive 5;
              '';
            };
          virtualHosts.${coffeeVaultDomain} = {
            forceSSL = true;
            useACMEHost = coffeeVaultDomain;
            locations."/" = {
              proxyPass = "http://coffee-vault";
              proxyWebsockets = true;
            };
          };
        };
      };
    };
}

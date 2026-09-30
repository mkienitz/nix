{ inputs, ... }:
{
  flake.modules.nixos.coffee-vault =
    {
      config,
      lib,
      ...
    }:
    let
      coffeeVaultDomain = "coffee.maxkienitz.com";
      flakeLib = inputs.self.lib;
    in
    {
      imports = [
        inputs.coffee-vault.nixosModules.default
        inputs.coffee-vault-print.nixosModules.default
        inputs.self.modules.nixos.acme-maxkienitz-com
      ];

      config = lib.mkMerge [
        (flakeLib.mkAcmeCert coffeeVaultDomain)
        (flakeLib.mkAcmeStatePersistence coffeeVaultDomain)
        {
          environment.persistence = {
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
            coffee-vault-print = {
              enable = true;
              port = 55555;
            };
            nginx =
              let
                inherit (config.services.coffee-vault) address port;
              in
              flakeLib.mkNginxProxy {
                name = "coffee-vault";
                domain = coffeeVaultDomain;
                inherit address port;
              };
          };
        }
      ];
    };
}

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

  config.flake.lib = {
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
  };
}

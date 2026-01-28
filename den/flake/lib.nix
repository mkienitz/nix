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
    # mkNixos = system: name: {
    #   ${name} = inputs.nixpkgs.lib.nixosSystem {
    #     modules = [
    #       inputs.self.modules.nixos.${name}
    #       { nixpkgs.hostPlatform = lib.mkDefault system; }
    #     ];
    #   };
    # };
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

    # mkDarwin = system: name: {
    #   ${name} = inputs.nix-darwin.lib.darwinSystem {
    #     modules = [
    #       inputs.self.modules.darwin.${name}
    #       { nixpkgs.hostPlatform = lib.mkDefault system; }
    #     ];
    #   };
    # };
    #
    # mkHomeManager = system: name: {
    #   ${name} = inputs.home-manager.lib.homeManagerConfiguration {
    #     pkgs = inputs.nixpkgs.legacyPackages.${system};
    #     modules = [
    #       inputs.self.modules.homeManager.${name}
    #       { nixpkgs.config.allowUnfree = true; }
    #     ];
    #   };
    # };

  };
}

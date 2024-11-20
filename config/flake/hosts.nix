{
  inputs,
  withSystem,
  ...
}:
{
  imports = [
    inputs.devshell.flakeModule
    inputs.pre-commit-hooks.flakeModule
  ];

  flake = {
    # Tim Apple
    darwinConfigurations.io = withSystem "aarch64-darwin" (
      { pkgs, ... }:
      inputs.darwin.lib.darwinSystem {
        inherit pkgs;
        specialArgs = {
          inherit inputs;
        };
        modules = [ ../../hosts/io ];
      }
    );

    # Not Tim Apple
    nixosConfigurations =
      let
        mkNixosHost =
          hostName: arch:
          (withSystem arch (
            { pkgs, ... }:
            inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs;
                inherit (pkgs) lib;
              };
              modules = [
                ../../hosts/${hostName}
                ../../modules/nixos
                {
                  node.hostName = hostName;
                  nixpkgs = {
                    hostPlatform = arch;
                    inherit (pkgs) overlays config;
                  };
                }
              ];
            }
          ));
      in
      {
        # Hetzner vServer
        gonggong = mkNixosHost "gonggong" "aarch64-linux";
        # Raspberry Pi 4
        hygiea = mkNixosHost "hygiea" "aarch64-linux";
        # Beelink Mini S12 Pro
        iapetus = mkNixosHost "iapetus" "x86_64-linux";
        # Desktop
        phoebe = mkNixosHost "phoebe" "x86_64-linux";
      };
  };

  perSystem =
    {
      config,
      pkgs,
      system,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    };
}

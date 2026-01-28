{
  inputs,
  withSystem,
  ...
}:
{
  flake = {
    # Tim Apple
    darwinConfigurations.io = withSystem "aarch64-darwin" (
      { pkgs, ... }:
      inputs.darwin.lib.darwinSystem {
        inherit pkgs;
        specialArgs = {
          inherit inputs;
        };
        modules = [ ../../../hosts/io ];
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
                # NOTE: Neccessary?
                inherit (pkgs) lib;
              };
              modules = [
                ../../../hosts/${hostName}
                ../../../modules/nixos
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
        # Desktop
        phoebe = mkNixosHost "phoebe" "x86_64-linux";
      };
  };
}

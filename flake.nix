{
  description = "Nix configurations for all machines";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    bipper.url = "github:mkienitz/bipper-rs";
    bipper.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    darwin,
    flake-utils,
    self,
    ...
  } @ inputs:
    {
      # Tim Apple
      darwinConfigurations.io = darwin.lib.darwinSystem {
        pkgs = self.pkgs.aarch64-darwin;
        specialArgs = {inherit inputs;};
        modules = [./hosts/io];
      };

      # Not Tim Apple
      nixosConfigurations = let
        mkNixosHost = hostname: arch:
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              inherit (self.pkgs.${arch}) lib;
            };
            modules = [
              ./hosts/${hostname}
              {
                nixpkgs.hostPlatform = arch;
                nixpkgs.overlays = self.pkgs.${arch}.overlays;
                nixpkgs.config = self.pkgs.${arch}.config;
              }
            ];
          };
      in {
        # Hetzner vServer
        gonggong = mkNixosHost "gonggong" "aarch64-linux";
        # Raspberry Pi 4
        hygiea = mkNixosHost "hygiea" "aarch64-linux";
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system: rec {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (_final: prev: {
              deploy = prev.callPackage ./pkgs/deploy.nix {};
            })
          ];
        };
        formatter = pkgs.alejandra;
        devShells.default = pkgs.mkShell {
          name = "devShell";
          packages = with pkgs; [
            deadnix
            deploy
            nil
            nix-tree
            statix
          ];
        };
      }
    );
}

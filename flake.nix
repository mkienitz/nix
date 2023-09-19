{
  description = "Nix configurations for all machines";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    darwin,
    flake-utils,
    self,
    ...
  } @ inputs:
    {
      nixosConfigurations.hygiea = nixpkgs.lib.nixosSystem {
        pkgs = self.pkgs.aarch64-linux;
        specialArgs = inputs;
        modules = [./hosts/hygiea];
      };

      nixosConfigurations.gonggong = nixpkgs.lib.nixosSystem {
        pkgs = self.pkgs.aarch64-linux;
        specialArgs = inputs;
        modules = [./hosts/gonggong];
      };

      darwinConfigurations.io = darwin.lib.darwinSystem {
        pkgs = self.pkgs.aarch64-darwin;
        modules = [./hosts/io];
      };

      darwinConfigurations.charon = darwin.lib.darwinSystem {
        pkgs = self.pkgs.x86_64-darwin;
        modules = [./hosts/charon];
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system: rec {
        pkgs = import nixpkgs {inherit system;};
        devShells.default = pkgs.mkShell {
          name = "devShell";
          packages = with pkgs; [alejandra nil deadnix nix-tree statix];
        };
      }
    );
}

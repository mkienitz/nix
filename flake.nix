{
  description = "Nix configurations for all machines";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
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
      nixosConfigurations.hygiea = nixpkgs.lib.nixosSystem rec {
        system = "aarch64-linux";
        pkgs = self.pkgs.${system};
        specialArgs = inputs;
        modules = [./hosts/hygiea];
      };

      darwinConfigurations.io = darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        pkgs = self.pkgs.${system};
        modules = [./hosts/io];
      };

      darwinConfigurations.charon = darwin.lib.darwinSystem rec {
        system = "x86_64-darwin";
        pkgs = self.pkgs.${system};
        modules = [./hosts/charon];
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system: rec {
        pkgs = import nixpkgs {inherit system;};
        devShells.default = pkgs.mkShell {
          name = "devShell";
          packages = with pkgs; [alejandra deadnix nix-tree statix];
        };
      }
    );
}

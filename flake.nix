{
  description = "Nix configurations for all machines";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations.hygiea = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      pkgs = import nixpgs {system = "aarch64-linux";};
      modules = [./hosts/hygiea];
    };
    darwinConfigurations.io = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import nixpgs {system = "aarch64-darwin";};
      modules = [./hosts/io];
    };
    darwinConfigurations.charon = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      pkgs = import nixpgs {system = "x86_64-darwin";};
      modules = [./hosts/charon];
    };

    devShells = nixpkgs.lib.genAttrs ["aarch64-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin"] (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        default = pkgs.mkShell {
          name = "devShell";
          packages = with pkgs; [alejandra deadnix nix-tree statix];
        };
      }
    );
  };
}

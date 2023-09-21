{
  description = "Nix configurations for all machines";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    darwin,
    flake-utils,
    colmena,
    self,
    ...
  } @ inputs:
    {
      # Colmena deployed nodes
      colmena = {
        meta = {
          nixpkgs = self.pkgs.x86_64-linux;
          nodeNixpkgs = {
            gonggong = self.pkgs.aarch64-linux;
            hygiea = self.pkgs.aarch64-linux;
          };
          specialArgs = {inherit inputs;};
        };
        gonggong.imports = [./hosts/gonggong];
        hygiea.imports = [./hosts/hygiea];
      };

      # Tim Apple
      darwinConfigurations.io = darwin.lib.darwinSystem {
        pkgs = self.pkgs.aarch64-darwin;
        specialArgs = {inherit inputs;};
        modules = [./hosts/io];
      };

      # Add a convenience alias 'hosts'
      nixosConfigurations = ((colmena.lib.makeHive self.colmena).introspect (x: x)).nodes;
      hosts = self.nixosConfigurations // self.darwinConfigurations;
    }
    // flake-utils.lib.eachDefaultSystem (
      system: rec {
        pkgs = import nixpkgs {inherit system;};
        devShells.default = pkgs.mkShell {
          name = "devShell";
          packages = with pkgs; [alejandra colmena.packages.${system}.colmena deadnix nil nix-tree statix];
        };
      }
    );
}

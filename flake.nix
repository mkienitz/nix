{
  inputs.nixpkgs.url = github:NixOS/nixpkgs;
  inputs.home-manager.url = github:nix-community/home-manager;

  outputs = {nixpkgs, ...} @ attrs: {
    nixosConfigurations.hygiea = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = attrs;
      modules = [./machines/hygiea.nix];
    };

    devShells = nixpkgs.lib.genAttrs ["aarch64-linux" "x86_64-linux"] (
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

{
  inputs.nixpkgs.url = github:NixOS/nixpkgs;
  inputs.home-manager.url = github:nix-community/home-manager;

  outputs = {nixpkgs, ...} @ attrs: {
    nixosConfigurations.hygiea = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = attrs;
      modules = [./machines/hygiea.nix];
    };
  };
}

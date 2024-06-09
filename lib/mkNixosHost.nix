inputs: hostName: arch:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit inputs;
    inherit (inputs.self.pkgs.${arch}) lib;
  };
  modules = [
    ../hosts/${hostName}
    ../modules/nixos
    {
      node.hostName = hostName;
      nixpkgs = {
        hostPlatform = arch;
        inherit (inputs.self.pkgs.${arch}) overlays config;
      };
    }
  ];
}

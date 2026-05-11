{ inputs, ... }:
{
  flake.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.default
      inputs.self.modules.generic.home-manager
    ];
  };

  flake.modules.darwin.home-manager = {
    imports = [
      inputs.home-manager.darwinModules.default
      inputs.self.modules.generic.home-manager
    ];
  };

  flake.modules.generic.home-manager = {
    home-manager = {
      useGlobalPkgs = true;
    };
  };
}

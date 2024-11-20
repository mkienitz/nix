{ inputs, ... }:
{
  imports = [
    inputs.home-manager.darwinModules.default
    ../common/hm.nix
  ];
}

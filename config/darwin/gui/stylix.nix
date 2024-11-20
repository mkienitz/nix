{ inputs, ... }:
{
  imports = [
    inputs.stylix.darwinModules.stylix
    ../../common/gui/stylix.nix
  ];
}

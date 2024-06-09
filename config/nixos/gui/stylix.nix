{inputs, ...}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ../../common/gui/stylix.nix
  ];
}

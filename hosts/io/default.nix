{
  imports = [
    ../../config/darwin
    ../../config/darwin/homebrew.nix
    ../../config/darwin/hm.nix
  ];
  home-manager.users.max.imports = [
    ../../config/hm/gui/stylix.nix
  ];
}

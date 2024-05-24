{
  inputs,
  pkgs,
  lib,
  ...
}: {
  # Don't setup user on darwin
  users.users.max = lib.mkIf (!pkgs.stdenv.isDarwin) {
    isNormalUser = true;
    shell = pkgs.zsh;
  };
  home-manager.useGlobalPkgs = true;
  home-manager.users.max = {
    imports = [
      inputs.nix-index-database.hmModules.nix-index
      inputs.nixvim.homeManagerModules.nixvim
      ../../modules/hm/gui
      ../../modules/hm/shell
      ../../modules/hm/shell/neovim
    ];
    home.username = "max";
    home.stateVersion = "23.11";
  };
}

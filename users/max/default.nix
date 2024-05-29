{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  # Don't setup user on darwin
  users.users.max = lib.mkIf (!pkgs.stdenv.isDarwin) {
    isNormalUser = true;
    shell = pkgs.zsh;
    inherit (config.users.users.root) hashedPassword;
  };
  home-manager.useGlobalPkgs = true;
  home-manager.users.max = {
    imports = [
      inputs.nix-index-database.hmModules.nix-index
      inputs.nixvim.homeManagerModules.nixvim
      ../../modules/hm/gui
      ../../modules/hm/shell
      ../../modules/hm/shell/neovim
      # Always add impermanence options, even if they aren't used.
      # This avoids the need for guards.
      ../../modules/hm/impermanence.nix
    ];
    home.username = "max";
    home.stateVersion = "23.11";
  };
}

{inputs, ...}: {
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

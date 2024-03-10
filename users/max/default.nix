{inputs, ...}: {
  home-manager.useGlobalPkgs = true;
  home-manager.users.max = {
    imports = [
      inputs.nix-index-database.hmModules.nix-index
      inputs.nixvim.homeManagerModules.nixvim
      ./shell
      ./graphical
      ./neovim
    ];
    home.username = "max";
    home.stateVersion = "23.11";
  };
}

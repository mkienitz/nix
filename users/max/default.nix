{inputs, ...}: {
  home-manager.useGlobalPkgs = true;
  home-manager.users.max = {
    imports = [
      inputs.nix-index-database.hmModules.nix-index
      ./shell
      ./graphical
    ];
    home.username = "max";
    home.stateVersion = "23.11";
  };
}

_: {
  home-manager.useGlobalPkgs = true;
  home-manager.users.max = {
    imports = [
      ./shell
      ./graphical
    ];
    home.username = "max";
    home.stateVersion = "23.11";
  };
}

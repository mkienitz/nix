{...}: {
  # If on darwin, setup graphical applications using homebrew
  imports = [
    ./graphical/homebrew.nix
    ./graphical/yabai.nix
  ];
  # Setup home manager modules for user
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

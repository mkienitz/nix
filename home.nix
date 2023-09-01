{
  config,
  pkgs,
  ...
}: {
  home.packages = [];
  home.stateVersion = "23.11";

  programs.git = {
    enable = true;
    userName = "Maximilian Kienitz";
    userEmail = "max@kienitz.dev";
  };
}

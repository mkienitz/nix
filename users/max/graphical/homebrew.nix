{
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf (pkgs.stdenv.isDarwin) {
    homebrew = {
      enable = true;
      global = {
        brewfile = true;
      };
      onActivation = {
        autoUpdate = false;
        cleanup = "zap";
      };
      brews = [
        "pinentry-mac"
      ];
      casks = [
        "docker"
        "adobe-creative-cloud"
        "discord"
        "google-chrome"
        "jetbrains-toolbox"
        "karabiner-elements"
        "kitty"
        "obsidian"
        "postman"
        "signal"
        "spotify"
        "zoom"
      ];
    };
  };
}

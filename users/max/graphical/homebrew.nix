{
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf pkgs.stdenv.isDarwin {
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
        "m1ddc"
        "pinentry-mac"
      ];
      casks = [
        "adobe-creative-cloud"
        "balenaetcher"
        "bruno"
        "discord"
        "docker"
        "google-chrome"
        "jetbrains-toolbox"
        "karabiner-elements"
        "kitty"
        "monodraw"
        "obsidian"
        "postman"
        "signal"
        "spotify"
        "zed"
        "zoom"
      ];
    };
  };
}

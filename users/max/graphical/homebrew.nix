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
        autoUpdate = true;
        cleanup = "zap";
        upgrade = true;
      };
      brews = [
        "m1ddc"
        "pinentry-mac"
      ];
      casks = [
        "adobe-creative-cloud"
        "alacritty"
        "balenaetcher"
        "bruno"
        "discord"
        "docker"
        "google-chrome"
        "jetbrains-toolbox"
        "karabiner-elements"
        "keyboardcleantool"
        "kitty"
        "monodraw"
        "mullvadvpn"
        "obsidian"
        "obs"
        "postman"
        "signal"
        "spotify"
        "zed"
        "zoom"
      ];
    };
  };
}

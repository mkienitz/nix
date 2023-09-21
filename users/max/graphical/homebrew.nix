{pkgs, lib, ...}: {
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
      casks = [
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

{
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
      "chatgpt"
      "discord"
      "docker"
      "google-chrome"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keyboardcleantool"
      "kitty"
      "macfuse"
      "monodraw"
      "mullvadvpn"
      "obs"
      "obsidian"
      "postman"
      "signal"
      "spotify"
      "zed"
      "zoom"
    ];
  };
}

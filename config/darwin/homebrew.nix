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
    taps = [
      "nikitabobko/tap"
    ];
    casks = [
      "adobe-creative-cloud"
      "aerospace"
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
      "teamspeak-client"
      "zed"
      "zoom"
    ];
  };
}

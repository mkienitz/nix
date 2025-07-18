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
      "bruno"
      "chatgpt"
      "discord"
      "docker-desktop"
      "google-chrome"
      "karabiner-elements"
      "keyboardcleantool"
      "kitty"
      "macfuse"
      "monodraw"
      "mullvadvpn"
      "obsidian"
      "orcaslicer"
      "rectangle"
      "signal"
      "spotify"
      "teamspeak-client"
      "zotero"
    ];
  };
}

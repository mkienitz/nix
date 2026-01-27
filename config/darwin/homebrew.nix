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
      "mole"
      "pinentry-mac"
    ];
    casks = [
      "adobe-creative-cloud"
      "bruno"
      "calibre"
      "chatgpt"
      "discord"
      "docker-desktop"
      "google-chrome"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keyboardcleantool"
      "kitty"
      "kicad"
      "logi-options+"
      "macfuse"
      "monodraw"
      "mullvad-vpn"
      "obsidian"
      "orcaslicer"
      "rectangle"
      "signal"
      "spotify"
      "teamspeak-client"
      "zap"
      "zoom"
      "zotero"
    ];
  };
}

{
  flake.modules.darwin.homebrew = {
    homebrew = {
      enable = true;
      global = {
        brewfile = false;
      };
      greedyCasks = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "zap";
        upgrade = true;
      };
      taps = [
        # for ketch
        {
          name = "1broseidon/tap";
          trusted = true;
        }
      ];
      brews = [
        "m1ddc"
        "mole"
        "pinentry-mac"
        # TODO: nixpkgs version is too trailing atm
        "ketch"
      ];
      casks = [
        "bruno"
        "calibre"
        "discord"
        "docker-desktop"
        "google-chrome"
        "jetbrains-toolbox"
        "karabiner-elements"
        "keyboardcleantool"
        "macfuse"
        "monodraw"
        "mullvad-vpn"
        "obsidian"
        "orcaslicer"
        "rectangle"
        "signal"
        "zoom"
      ];
    };
  };

  flake.modules.homeManager.homebrew = {
    home.sessionPath = [ "/opt/homebrew/bin/" ];
  };
}

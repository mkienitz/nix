{...}: {
  imports = [
    ../../modules/darwin
    ../../users/max
  ];
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      protocol = "ssh-ng";
      system = "aarch64-linux";
      hostName = "gonggong";
      supportedFeatures = ["big-parallel" "kvm"];
    }
  ];
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
      "docker"
      "firefox"
      "google-chrome"
      "jetbrains-toolbox"
      "karabiner-elements"
      "kitty"
      "obs"
      "obsidian"
      "owasp-zap"
      "postman"
      "signal"
      "spotify"
      "zoom"
    ];
  };
}

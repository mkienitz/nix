{pkgs, ...}: {
  programs.zsh.enable = true;

  environment = {
    loginShell = pkgs.zsh;
    shells = with pkgs; [bash zsh];
    systemPackages = with pkgs; [coreutils openssh];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [(nerdfonts.override {fonts = ["JetBrainsMono"];})];
  };

  nix = {
    settings.experimental-features = "nix-command flakes";
    distributedBuilds = true;
    buildMachines = [
      {
        protocol = "ssh-ng";
        system = "aarch64-linux";
        hostName = "gonggong";
        maxJobs = 8;
        supportedFeatures = ["big-parallel" "kvm"];
      }
      {
        protocol = "ssh-ng";
        system = "x86_64-linux";
        hostName = "iapetus";
        maxJobs = 8;
        supportedFeatures = ["big-parallel" "kvm"];
      }
    ];
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  services.nix-daemon.enable = true;

  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };
    dock.autohide = true;
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      NSWindowShouldDragOnGesture = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
    };
  };

  users.users.max = {
    name = "max";
    home = "/Users/max";
  };
}

{
  pkgs,
  inputs,
  ...
}: {
  programs.zsh.enable = true;

  environment = {
    loginShell = pkgs.zsh;
    shells = with pkgs; [bash zsh];
    systemPackages = with pkgs; [coreutils openssh];
  };

  nix = {
    settings.experimental-features = "nix-command flakes";
    distributedBuilds = true;
    registry.p.flake = inputs.nixpkgs;
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
        hostName = "phoebe";
        maxJobs = 8;
        speedFactor = 9001;
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
    CustomUserPreferences."org.gpgtools.common" = {
      DisableKeychain = false;
      UseKeychain = true;
    };
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

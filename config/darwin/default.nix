{ pkgs, ... }:
{
  imports = [
    ../common
  ];

  environment.systemPackages = with pkgs; [
    coreutils
    openssh
  ];

  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        protocol = "ssh-ng";
        system = "aarch64-linux";
        hostName = "gonggong";
        maxJobs = 8;
        supportedFeatures = [
          "big-parallel"
          "kvm"
        ];
      }
      {
        protocol = "ssh-ng";
        system = "x86_64-linux";
        hostName = "iapetus";
        maxJobs = 8;
        supportedFeatures = [
          "big-parallel"
          "kvm"
        ];
      }
    ];
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  services.nix-daemon.enable = true;

  system = {
    defaults = {
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
    stateVersion = 5;
  };

  users.users.max = {
    name = "max";
    home = "/Users/max";
  };
}

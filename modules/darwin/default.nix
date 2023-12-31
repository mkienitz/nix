{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.darwinModules.default];
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      protocol = "ssh-ng";
      system = "aarch64-linux";
      hostName = "gonggong";
      maxJobs = 8;
      supportedFeatures = ["big-parallel" "kvm"];
    }
  ];

  programs.zsh.enable = true;
  users.users.max.name = "max";
  users.users.max.home = "/Users/max";
  environment = {
    shells = with pkgs; [bash zsh];
    loginShell = pkgs.zsh;
    systemPackages = with pkgs; [coreutils openssh];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [(nerdfonts.override {fonts = ["JetBrainsMono"];})];
  };

  services.nix-daemon.enable = true;
  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };
    dock.autohide = true;
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
    };
  };
}

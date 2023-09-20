{
  pkgs,
  inputs,
  ...
}: {
  nix.settings.experimental-features = "nix-command flakes";
  imports = [inputs.home-manager.darwinModules.default];

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

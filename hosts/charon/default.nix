{
  pkgs,
  home-manager,
  ...
}: {
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [bash zsh];
    loginShell = pkgs.zsh;
    systemPackages = with pkgs; [coreutils];
    fonts = {
      fontDir.enable = true;
      fonts = with pkgs; [(nerdfonts.override {fonts = ["JetBrainsMono"];})];
    };
  };
  services.nix-daemon.enable = true;
  services.nix-daemon.package = pkgs.nixFlakes;
  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };
    dock.autohide = true;
    NSGlobalDomain = {
      # AppleShowAllExtensions = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
    };
  };
}

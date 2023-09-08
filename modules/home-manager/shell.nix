pkgs: {
  home.packages = with pkgs; [eza fd file ripgrep];
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    history.size = 100000;
    history.save = 100000;
  };

  home.shellAliases = {
    ll = "eza -l";
    la = "eza -la";
    tree = "eza -T";
    lg = "lazygit";
    update = "sudo nixos-rebuild --flake ~/nix-config switch";
  };
}

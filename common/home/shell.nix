{
  programs.zsh = {
    enable = true;
    history.size = 100000;
    history.save = 100000;
  };

  home.shellAliases = {
    ll = "exa -l";
    la = "exa -la";
    tree = "exa -T";
    lg = "lazygit";
    update = "sudo nixos-rebuild --flake ~/nix-config switch";
  };
}

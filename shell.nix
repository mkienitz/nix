{
  programs.zsh = {
    enable = true;
    history.size = 100000;
    history.save = 100000;
  };

  home.shellAliases = {
    ll = "ls -l";
    la = "ls -la";
    lg = "lazygit";
    update = "sudo nixos-rebuild --flake ~/nix-config switch";
    alejandro = "alejandra .";
  };
}

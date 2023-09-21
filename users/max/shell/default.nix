{
  pkgs,
  lib,
  ...
}: {
  imports = [./starship.nix];
  home.packages = with pkgs; [
    neovim
    tree-sitter
    timg
    bat
    cloc
    curl
    eza
    fd
    fzf
    git-filter-repo
    hexyl
    hyperfine
    ripgrep
    tldr
    wget
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    envExtra = lib.readFile ./zshenv;
    history = {
      size = 100000;
      save = 100000;
    };
    enableAutosuggestions = true;
    defaultKeymap = "emacs";
  };

  home.sessionVariablesExtra = lib.optionalString pkgs.stdenv.isDarwin ''
    export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
  '';

  home.shellAliases = {
    c = "clear";
    vim = "nvim";
    weather = "curl wttr.in/Munich";
    zz = "z -";
    ls = "eza";
    l = "eza";
    llt = "eza --long --tree";
    ll = "eza -l";
    la = "eza -la";
    tree = "eza -T";
    lg = "lazygit";
  };
}

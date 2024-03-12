{pkgs, ...}: {
  imports = [
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
  ];

  home = {
    # Various command line tools
    packages = with pkgs; [
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

    shellAliases = {
      c = "clear";
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
  };

  programs = {
    nix-index-database.comma.enable = true;
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}

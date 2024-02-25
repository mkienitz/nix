{
  pkgs,
  lib,
  ...
}: {
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
      comma
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

    sessionVariablesExtra = lib.optionalString pkgs.stdenv.isDarwin ''
      export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
    '';

    shellAliases = {
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
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}

{
  pkgs,
  lib,
  ...
}: {
  imports = [./starship.nix];

  # Various command line tools
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

  #
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
    initExtraFirst = ''
      if autoload history-search-end; then
        zle -N history-beginning-search-backward-end history-search-end
        zle -N history-beginning-search-forward-end  history-search-end
      fi
    '';
    history = {
      size = 100000;
      save = 100000;
    };
    defaultKeymap = "emacs";
    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-autosuggestions";
        file = "zsh-autosuggestions.zsh";
        src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
      }
    ];
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

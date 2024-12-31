{ pkgs, ... }:
{
  programs = {
    fzf = {
      enable = true;
      defaultOptions = [
        "--height 40%"
        "--reverse"
        "--ansi"
      ];
    };
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      initExtraFirst = ''
        if autoload history-search-end; then
          zle -N history-beginning-search-backward-end history-search-end
          zle -N history-beginning-search-forward-end history-search-end
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
      shellAliases = {
        c = "clear";
        l = "eza";
        la = "eza -la";
        lat = "eza -lat modified";
        lg = "lazygit";
        ll = "eza -l";
        llt = "eza --long --tree";
        ls = "eza";
        tree = "eza -T";
        weather = "curl wttr.in/Munich";
        zz = "z -";
        py = "python3";
      };
    };
  };
  home.persistence."/state".files = [
    ".zsh_history"
  ];
}

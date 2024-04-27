{pkgs, ...}: {
  programs = {
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
    };
  };
}

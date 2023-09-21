{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    historyLimit = 100000;
    mouse = true;
    sensibleOnTop = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = ''
      set -ag terminal-overrides ",*:RGB"
      set -g @tmux-nvim-resize-step-x 5
      set -g @tmux-nvim-resize-step-y 5
      unbind '"'
      unbind %
      bind s split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"
      bind x kill-pane
      bind & kill-window
    '';
  };
}

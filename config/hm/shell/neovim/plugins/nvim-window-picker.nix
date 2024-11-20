{ pkgs, ... }:
{
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = nvim-window-picker;
      lazy = true;
      opts = {
        hint = "floating-big-letter";
        filter_rules = {
          bo = {
            filetype = [
              "neo-tree"
              "neo-tree-popup"
              "notify"
              "quickfix"
            ];
            buftype = [
              "terminal"
              "quickfix"
              "prompt"
            ];
          };
        };
        floating_big_letter = {
          font = "ansi-shadow";
        };
        show_prompt = false;
      };
    }
  ];
}

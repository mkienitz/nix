{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      nvim-window-picker
    ];
    extraConfigLuaPost = ''
      require("window-picker").setup {
        hint = "floating-big-letter",
        filter_rules = {
          bo = {
            filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },
            buftype = { "terminal", "quickfix", "prompt" },
          },
        },
        floating_big_letter = {
          font = "ansi-shadow",
        },
        show_prompt = false,
      }
    '';
    keymaps = [
      {
        key = "<C-w><space>";
        mode = "n";
        action = "<cmd>lua require('window-picker').pick_window()<cr>";
        options = {
          desc = "Open window picker";
        };
      }
    ];
  };
}

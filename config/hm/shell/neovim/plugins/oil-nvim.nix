{
  pkgs,
  config,
  ...
}:
let
  inherit (config.lib) moovim;
in
{
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = oil-nvim;
      dependencies = [ nvim-web-devicons ];
      opts = {
        keymaps = {
          "<C-h>" = false;
          "<C-l>" = false;
          "<C-r>" = "actions.refresh";
        };
        view_options = {
          show_hidden = true;
        };
      };
      keys = moovim.mkLazyKeys [
        {
          lhs = "<leader>o";
          rhs = "<cmd>Oil<cr>";
          desc = "Open Oil";
        }
      ];
    }
  ];
}

{
  pkgs,
  config,
  ...
}: let
  inherit (config.lib) moovim;
in {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = oil-nvim;
      config = true;
      dependencies = [nvim-web-devicons];
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

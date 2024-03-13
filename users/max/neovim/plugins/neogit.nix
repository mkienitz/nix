{
  pkgs,
  config,
  ...
}: let
  inherit (config.lib) moovim;
in {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = neogit;
      config = true;
      dependencies = [plenary-nvim];
      keys = moovim.mkLazyKeys [
        {
          lhs = "<leader>gg";
          rhs = "<cmd>Neogit<cr>";
          desc = "Open Neogit";
        }
      ];
    }
  ];
}

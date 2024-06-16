{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = gruvbox-nvim;
      priority = 1000;
      opts = {
        overrides = {
          SignColumn = {
            bg = "#282828";
          };
        };
      };
      config =
        # lua
        ''
          function(_, opts)
            require("gruvbox").setup(opts)
          vim.cmd("colorscheme gruvbox")
          end
        '';
    }
  ];
}

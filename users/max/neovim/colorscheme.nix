_: {
  programs.nixvim = {
    colorschemes.gruvbox = {
      enable = true;
      settings = {
        overrides = {
          SignColumn = {
            bg = "#282828";
          };
        };
      };
    };
    # hack because colorscheme needs to be loaded AFTER gruvbox.setup()
    extraConfigLuaPost = "vim.cmd('colorscheme gruvbox')";
  };
}

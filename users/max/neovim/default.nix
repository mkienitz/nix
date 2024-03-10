_: {
  imports = [
    ./plugins
  ];
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    colorschemes.gruvbox = {
      enable = true;
      settings = {
        contrast = "soft";
        overrides = {
          SignColumn = {
            bg = "#282828";
          };
        };
      };
    };
    keymaps = [
    ];
  };
}

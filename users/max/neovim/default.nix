_: {
  imports = [
    ./plugins
    ./filetypes.nix
    ./options.nix
    ./colorscheme.nix
  ];
  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    globals.mapleader = " ";
  };
}

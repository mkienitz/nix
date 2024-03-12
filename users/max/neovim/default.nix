_: {
  imports = [
    ./plugins
    ./colorscheme.nix
  ];
  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    globals.mapleader = " ";
  };
}

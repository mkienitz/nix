{
  imports = [
    ./filetypes.nix
    ./keymap.nix
    ./options.nix
    ./plugins
  ];
  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
  };
}

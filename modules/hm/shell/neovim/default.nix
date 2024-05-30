{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./filetypes.nix
    ./keymap.nix
    ./moovim.nix
    ./options.nix
    ./plugins
  ];
  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
  };
  home.persistence."/state".directories = [".cache/nvim"];
}

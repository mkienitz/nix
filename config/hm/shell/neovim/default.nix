{
  inputs,
  pkgs,
  ...
}:
{
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
  home.packages = [
    (pkgs.writeShellScriptBin "view_nixvim_output" ''
      set -e
      cp ~/.config/nvim/init.lua /tmp/pretty.lua
      chmod 600 /tmp/pretty.lua
      ${pkgs.stylua}/bin/stylua /tmp/pretty.lua
      vim /tmp/pretty.lua
    '')
  ];
  home.persistence."/state".directories = [ ".cache/nvim" ];
}

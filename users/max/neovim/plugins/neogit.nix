{
  pkgs,
  config,
  ...
}: let
  inherit (config.nixvim) helpers;
in {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = neogit;
      config = true;
      dependencies = [plenary-nvim];
      keys.__raw = helpers.toLuaObject [
        ((helpers.listToUnkeyedAttrs
          ["<leader>gg" "<cmd>Neogit<cr>"])
        // {desc = "Open Neogit";})
      ];
    }
  ];
}

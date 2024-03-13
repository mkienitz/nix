{
  pkgs,
  config,
  ...
}: let
  inherit (config.nixvim) helpers;
in {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = leap-nvim;
      lazy = false;
      opts = {case_sensitive = true;};
      keys.__raw = helpers.toLuaObject [
        ((helpers.listToUnkeyedAttrs
          ["s" "<Plug>(leap-forward-to)"])
        // {desc = "Leap forward";})
        ((helpers.listToUnkeyedAttrs
          ["S" "<Plug>(leap-backward-to)"])
        // {desc = "Leap backward";})
        ((helpers.listToUnkeyedAttrs
          ["gs" "<Plug>(leap-cross-windows)"])
        // {desc = "Leap across windows";})
      ];
    }
  ];
}

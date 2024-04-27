{
  programs.nixvim = let
    mkIndentSettings = lang: width: expandTab: {
      name = "ftplugin/${lang}.lua";
      value = {
        opts = {
          expandtab = expandTab;
          shiftwidth = width;
          tabstop = width;
          softtabstop = width;
        };
      };
    };
  in {
    files = builtins.listToAttrs [
      (mkIndentSettings "haskell" 2 true)
      (mkIndentSettings "html" 2 false)
      (mkIndentSettings "javascript" 2 false)
      (mkIndentSettings "lua" 2 false)
      (mkIndentSettings "nix" 2 true)
      (mkIndentSettings "svelte" 2 false)
      (mkIndentSettings "typescript" 2 false)
      (mkIndentSettings "typescriptreact" 2 false)
    ];
  };
}

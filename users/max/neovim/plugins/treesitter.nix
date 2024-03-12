_: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        indent = true;
        incrementalSelection = {
          enable = true;
          keymaps = {
            initSelection = "<C-space>";
            nodeIncremental = "<C-space>";
            scopeIncremental = "false";
            nodeDecremental = "<bs>";
          };
        };
      };
    };
  };
}

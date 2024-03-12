_: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        ensureInstalled = ["c" "java" "haskell" "lua" "rust" "python" "cpp" "typescript" "scss" "svelte"];
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

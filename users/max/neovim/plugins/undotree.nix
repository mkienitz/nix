{
  programs.nixvim = {
    plugins = {
      undotree = {
        enable = true;
      };
    };
    keymaps = [
      {
        key = "<leader>u";
        mode = "n";
        action = "<cmd>UndotreeToggle<cr>";
        options = {
          desc = "Toggle UndoTree";
        };
      }
    ];
  };
}

{
  programs.nixvim = {
    globals.mapleader = " ";
    keymaps = [
      # Center after scrolling up and down
      {
        key = "<C-u>";
        mode = "n";
        action = "<C-u>zz";
      }
      {
        key = "<C-d>";
        mode = "n";
        action = "<C-d>zz";
      }
      # Paste clipboard below/above the current line
      {
        key = "<leader>p>";
        mode = "n";
        action = "<cmd>pu<cr>";
      }
      {
        key = "<leader>P>";
        mode = "n";
        action = "<cmd>pu!<cr>";
      }
      # Append next line to end of current line
      {
        key = "J";
        mode = "n";
        action = "mzJ`z";
      }
    ];
  };
}

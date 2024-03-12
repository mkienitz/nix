{
  programs.nixvim = {
    plugins = {
      neogit.enable = true;
    };
    keymaps = [
      {
        key = "<leader>gg";
        mode = "n";
        action = "<cmd>Neogit<cr>";
        options = {
          desc = "Open Neogit";
        };
      }
    ];
  };
}

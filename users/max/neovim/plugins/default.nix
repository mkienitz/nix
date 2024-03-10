{pkgs, ...}: {
  imports = [
    ./telescope.nix
    ./neo-tree.nix
    ./leap.nix
    ./nvim-window-picker.nix
  ];
  programs.nixvim = {
    plugins = {
      tmux-navigator.enable = true;
      which-key.enable = true;
      todo-comments.enable = true;
      neogit.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      nvim-surround
    ];
    extraConfigLuaPost = ''
      require('nvim-surround').setup()
    '';
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

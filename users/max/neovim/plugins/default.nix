{
  imports = [
    ./alpha.nix
    ./leap.nix
    ./lualine.nix
    ./neo-tree.nix
    ./neogit.nix
    ./nvim-surround.nix
    ./nvim-window-picker.nix
    ./telescope.nix
    ./treesitter.nix
    ./undotree.nix
    ./lsp
  ];
  programs.nixvim = {
    plugins = {
      tmux-navigator.enable = true;
      which-key.enable = true;
      todo-comments.enable = true;
      gitsigns.enable = true;
      comment-nvim.enable = true;
      nvim-autopairs.enable = true;
    };
  };
}

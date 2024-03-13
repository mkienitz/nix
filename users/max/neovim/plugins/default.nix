{
  imports = [
    ./lsp
    ./alpha.nix
    ./comment-nvim.nix
    ./fidget.nix
    ./gitsigns.nix
    ./gruvbox.nix
    ./leap.nix
    ./lualine.nix
    ./neo-tree.nix
    ./neogit.nix
    ./nvim-autopairs.nix
    ./nvim-surround.nix
    ./nvim-window-picker.nix
    ./telescope.nix
    ./todo-comments.nix
    ./treesitter.nix
    ./undotree.nix
    ./vim-tmux-navigator.nix
    ./which-key.nix
  ];
  programs.nixvim.plugins.lazy.enable = true;
}

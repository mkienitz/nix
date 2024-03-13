{pkgs, ...}: {
  imports = [
    ./lsp
    ./alpha.nix
    ./fidget.nix
    ./gruvbox.nix
    ./leap.nix
    ./lualine.nix
    ./neo-tree.nix
    ./neogit.nix
    ./nvim-window-picker.nix
    ./telescope.nix
    ./treesitter.nix
    ./undotree.nix
  ];
  programs.nixvim.plugins.lazy = {
    enable = true;
    # Plugins with no special configuration go here
    plugins = with pkgs.vimPlugins; [
      {
        pkg = comment-nvim;
        config = true;
      }
      {
        pkg = gitsigns-nvim;
        config = true;
      }
      {
        pkg = nvim-autopairs;
        config = true;
      }
      {
        pkg = nvim-surround;
        config = true;
      }
      {
        pkg = todo-comments-nvim;
        config = true;
      }
      {
        pkg = vim-tmux-navigator;
      }
      {
        pkg = which-key-nvim;
        config = true;
      }
    ];
  };
}

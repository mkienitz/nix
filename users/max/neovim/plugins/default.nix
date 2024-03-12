{pkgs, ...}: {
  imports = [
    ./alpha.nix
    ./leap.nix
    ./neo-tree.nix
    ./neogit.nix
    ./nvim-window-picker.nix
    ./telescope.nix
    ./treesitter.nix
  ];
  programs.nixvim = {
    plugins = {
      tmux-navigator.enable = true;
      which-key.enable = true;
      todo-comments.enable = true;
      gitsigns.enable = true;
      comment-nvim.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      nvim-surround
    ];
    extraConfigLuaPost = ''
      require('nvim-surround').setup()
    '';
  };
}

{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = todo-comments-nvim;
      opts = {};
    }
  ];
}

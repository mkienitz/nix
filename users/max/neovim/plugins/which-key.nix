{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = which-key-nvim;
      opts = {};
    }
  ];
}

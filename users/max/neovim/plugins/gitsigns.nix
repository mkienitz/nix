{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = gitsigns-nvim;
      opts = {};
    }
  ];
}

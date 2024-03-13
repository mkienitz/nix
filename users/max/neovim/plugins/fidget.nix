{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = fidget-nvim;
      event = "LspAttach";
      opts.notification.window.winblend = 0;
    }
  ];
}

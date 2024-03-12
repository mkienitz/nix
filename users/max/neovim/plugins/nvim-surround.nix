{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      nvim-surround
    ];
    extraConfigLuaPost = ''
      require('nvim-surround').setup()
    '';
  };
}

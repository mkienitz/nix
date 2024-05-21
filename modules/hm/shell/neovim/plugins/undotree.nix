{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = undotree;
      dependencies = [which-key-nvim];
      config =
        /*
        lua
        */
        ''
          function(_, _)
            require("which-key").register({
              ["<leader>u"] = { "<cmd>UndotreeToggle<CR>", "Toggle UndoTree" }
            })
          end
        '';
    }
  ];
}

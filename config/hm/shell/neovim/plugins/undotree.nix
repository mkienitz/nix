{ pkgs, ... }:
{
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = undotree;
      dependencies = [ which-key-nvim ];
      config =
        # lua
        ''
          function(_, _)
            require("which-key").add({
              { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
            })
          end
        '';
    }
  ];
}

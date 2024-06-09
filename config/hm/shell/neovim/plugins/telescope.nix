{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = telescope-nvim;
      lazy = true;
      dependencies = [telescope-fzf-native-nvim];
      opts = {
        defaults = {
          mappings = {
            i = {
              "<C-j>" = "move_selection_next";
              "<C-k>" = "move_selection_previous";
              "<C-h>" = "which_key";
            };
          };
        };
      };
      config =
        /*
        lua
        */
        ''
          function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
            local tsb = require("telescope.builtin")
              local wk = require("which-key")
              wk.register({
                ["<leader>f"] = {
                  name = "Find",
                  f = { tsb.find_files, "Local files" },
                  g = { tsb.git_files, "Git files" },
                  r = { tsb.oldfiles, "Old files" },
                  b = { tsb.buffers, "Buffers" },
                  c = { tsb.grep_string, "String under cursor" },
                  s = { tsb.live_grep, "String in current working directory" },
                  t = { tsb.treesitter, "Treesitter symbols" },
                },
              })
          end
        '';
    }
  ];
}

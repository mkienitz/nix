{
  programs.nixvim = {
    plugins = {
      telescope = {
        enable = true;
        enabledExtensions = ["fzf"];
        extensions.fzf-native.enable = true;
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
    };
    keymaps = [
      {
        key = "<leader>ff";
        mode = "n";
        action = "<cmd>lua require('telescope.builtin').find_files()<cr>";
        options = {
          desc = "Find local files";
        };
      }
      {
        key = "<leader>fg";
        mode = "n";
        action = "<cmd>lua require('telescope.builtin').git_files()<cr>";
        options = {
          desc = "Find Git files";
        };
      }
      {
        key = "<leader>fr";
        mode = "n";
        action = "<cmd>lua require('telescope.builtin').oldfiles()<cr>";
        options = {
          desc = "Find old files";
        };
      }
      {
        key = "<leader>fb";
        mode = "n";
        action = "<cmd>lua require('telescope.builtin').buffers()<cr>";
        options = {
          desc = "Find buffers";
        };
      }
      {
        key = "<leader>fc";
        mode = "n";
        action = "<cmd>lua require('telescope.builtin').grep_string()<cr>";
        options = {
          desc = "Grep string under cursor";
        };
      }
      {
        key = "<leader>fs";
        mode = "n";
        action = "<cmd>lua require('telescope.builtin').live_grep()<cr>";
        options = {
          desc = "Grep in current working directory";
        };
      }
      {
        key = "<leader>ft";
        mode = "n";
        action = "<cmd>lua require('telescope.builtin').treesitter()<cr>";
        options = {
          desc = "Treesitter symbols";
        };
      }
    ];
    extraConfigLuaPost =
      /*
      lua
      */
      ''
        require("which-key").register({
          ["<leader>f"] = { name = "Find" }
        })
      '';
  };
}

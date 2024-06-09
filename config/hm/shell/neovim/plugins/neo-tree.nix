{
  pkgs,
  config,
  ...
}: let
  inherit (config.lib) moovim;
in {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = neo-tree-nvim;
      dependencies = [plenary-nvim nui-nvim nvim-web-devicons nvim-window-picker];
      opts = {
        close_if_last_window = true;
        popup_border_style = "rounded";
        default_component_configs = {
          container = {
            enable_character_fade = false;
          };
          git_status = {
            symbols = {
              added = "A";
              deleted = "D";
              modified = "M";
              renamed = "R";
              untracked = "?";
              ignored = "I";
              unstaged = "U";
              staged = "S";
              conflict = "X";
            };
          };
        };
        window = {
          width = 36;
          mappings."Z" = "expand_all_nodes";
        };
        filesystem = {
          filtered_items = {
            force_visible_in_empty_folder = true;
            hide_dotfiles = false;
            hide_by_name = [".git"];
            never_show = [".DS_Store"];
          };
          group_empty_dirs = true;
          follow_current_file = {
            enabled = true;
          };
          use_libuv_file_watcher = true;
        };
      };
      keys = moovim.mkLazyKeys [
        {
          lhs = "<leader>t";
          rhs = "<cmd>Neotree action=show toggle<cr>";
          desc = "Open Neotree";
        }
      ];
    }
  ];
}

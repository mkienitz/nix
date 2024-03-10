_: {
  programs.nixvim = {
    plugins = {
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        popupBorderStyle = "rounded";
        defaultComponentConfigs = {
          container = {
            enableCharacterFade = false;
          };
          gitStatus = {
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
        };
        filesystem = {
          filteredItems = {
            forceVisibleInEmptyFolder = true;
            hideDotfiles = false;
            hideByName = [".git"];
            neverShow = [".DS_Store"];
          };
          groupEmptyDirs = true;
          followCurrentFile = {
            enabled = true;
          };
          useLibuvFileWatcher = true;
        };
        renderers = {
        };
      };
    };
    keymaps = [
      {
        key = "<leader>t";
        mode = "n";
        action = "<cmd>Neotree action=show toggle<cr>";
        options = {
          desc = "Toggle Neo-tree";
        };
      }
    ];
  };
}

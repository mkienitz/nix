{lib, ...}: {
  programs.nixvim = {
    plugins = {
      alpha = {
        enable = true;
        iconsEnabled = true;
        layout = let
          mkPadding = val: {
            type = "padding";
            inherit val;
          };
          mkButton = {
            val,
            shortcut,
          }: extra: (lib.recursiveUpdate {
              type = "button";
              opts = {
                position = "center";
                width = 30;
                cursor = 3;
                inherit shortcut;
                align_shortcut = "right";
                hl_shortcut = "keyword";
              };
              inherit val;
              # Somehow, the n defined presses will be mapped to the buttons 1:1, starting from the beginning
              # This prevents this "squashing"
              on_press.__raw = "function() end";
            }
            extra);
        in [
          (mkPadding 4)
          {
            type = "text";
            val = [
              "                        _    ___           "
              "   ____ ___  ____  ____| |  / (_)___ ___   "
              "  / __ `__ \\/ __ \\/ __ \\ | / / / __ `__ \\ "
              " / / / / / / /_/ / /_/ / |/ / / / / / / /  "
              "/_/ /_/ /_/\\____/\\____/|___/_/_/ /_/ /_/ "
            ];
            opts = {
              position = "center";
            };
          }
          (mkPadding 2)
          {
            type = "group";
            opts.spacing = 1;
            val = [
              (mkButton {
                  shortcut = "e";
                  val = "  New File";
                } {
                  on_press.__raw = "function() vim.cmd[[ene]] end";
                  opts.keymap = [
                    "n"
                    "e"
                    ":enew<cr>"
                    {
                      noremap = true;
                      silent = true;
                      nowait = true;
                    }
                  ];
                })
              (mkButton {
                shortcut = "SPC  t";
                val = "  Toggle File Explorer";
              } {})
              (mkButton {
                shortcut = "SPC ff";
                val = "󰱼  Local Files";
              } {})
              (mkButton {
                shortcut = "SPC fg";
                val = "  Git Files";
              } {})
              (mkButton {
                shortcut = "SPC fr";
                val = "󱋢  Recent Files";
              } {})
              (mkButton {
                shortcut = "SPC fs";
                val = "  Find String";
              } {})
              (mkButton {
                  shortcut = "q";
                  val = "  Quit";
                } {
                  on_press.__raw = "function() vim.cmd[[qa]] end";
                  opts.keymap = [
                    "n"
                    "q"
                    ":qa<cr>"
                    {
                      noremap = true;
                      silent = true;
                      nowait = true;
                    }
                  ];
                })
            ];
          }
        ];
      };
    };
  };
}

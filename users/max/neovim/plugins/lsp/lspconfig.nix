{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins = {
      lspsaga = {
        enable = true;
        lightbulb.enable = false;
        rename.keys.quit = "<esc>";
      };
      lsp = {
        enable = true;
        servers = {
          nil_ls = {
            enable = true;
            settings = {
              formatting.command = [(lib.getExe pkgs.alejandra) "--quiet"];
            };
          };
          rust-analyzer = {
            enable = true;
            settings = {
              checkOnSave = true;
              check.command = "clippy";
              files.excludeDirs = [".direnv"];
            };
            installCargo = false;
            installRustc = false;
          };
        };
      };
    };
    keymaps = [
      {
        key = "K";
        mode = "n";
        action = "<cmd>Lspsaga hover_doc<cr>";
        options = {
          desc = "Hover documentation";
        };
      }
      {
        key = "gd";
        mode = "n";
        action = "<cmd>lua vim.lsp.buf.definition()<cr>";
        options = {desc = "Definition";};
      }
      {
        key = "gD";
        mode = "n";
        action = "<cmd>lua vim.lsp.buf.declaration()<cr>";
        options = {desc = "Declaration";};
      }
      {
        key = "gi";
        mode = "n";
        action = "<cmd>lua vim.lsp.buf.implementation()<cr>";
        options = {desc = "Implementation";};
      }
      {
        key = "go";
        mode = "n";
        action = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
        options = {desc = "Type definition";};
      }
      {
        key = "gr";
        mode = "n";
        action = "<cmd>lua vim.lsp.buf.references()<cr>";
        options = {desc = "References";};
      }
      {
        key = "<leader>c";
        mode = "n";
        action = "<cmd>Lspsaga code_action<cr>";
        options = {desc = "Show code actions";};
      }
      {
        key = "<leader>rn";
        mode = "n";
        action = "<cmd>Lspsaga rename<cr>";
        options = {desc = "Rename symbol";};
      }
      {
        key = "<leader>e";
        mode = "n";
        action = "<cmd>lua vim.diagnostic.open_float<cr>";
        options = {desc = "Show diagnostics for line";};
      }
      {
        key = "<leader>E";
        mode = "n";
        action = "<cmd>lua require('telescope.builtin').diagnostics()<cr>";
        options = {desc = "Show available diagnostics";};
      }
      {
        key = "<leader>F";
        mode = "n";
        action = "<cmd>lua vim.lsp.buf.format()<cr>";
        options = {desc = "Format buffer";};
      }
      {
        key = "]d";
        mode = "n";
        action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
        options = {desc = "Jump to next diagnostic";};
      }
      {
        key = "[d";
        mode = "n";
        action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
        options = {desc = "Jump to previous diagnostic";};
      }
    ];
    extraConfigLuaPost =
      /*
      lua
      */
      ''
        require("which-key").register({
          ["<leader>g"] = { name = "Goto" }
        })
      '';
  };
}

{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      onAttach =
        /*
        lua
        */
        ''
          if client.name == "tailwindcss" then
            require("tailwindcss-colors").buf_attach(bufnr)
          end
          require("which-key").register({
            K = { vim.lsp.buf.hover, "Hover documentation", buffer = bufnr },
            g = {
              name = "Go to",
              d = { vim.lsp.buf.definition, "Definition", buffer = bufnr },
              D = { vim.lsp.buf.declaration, "Declaration", buffer = bufnr },
              i = { vim.lsp.buf.implementation, "Implementation", buffer = bufnr },
              o = { vim.lsp.buf.type_definition, "Type definition", buffer = bufnr },
              r = { vim.lsp.buf.references, "References", buffer = bufnr },
            },
            ["[d"] = { vim.diagnostic.goto_next, "Jump to next diagnostic", buffer = bufnr },
            ["]d"] = { vim.diagnostic.goto_prev, "Jump to previous diagnostic", buffer = bufnr },
            ["<leader>"] = {
              c = { vim.lsp.buf.code_action, "Show code actions", buffer = bufnr },
              rn = { vim.lsp.buf.rename, "Rename symbol", buffer = bufnr },
              vws = { vim.lsp.buf.workspace_symbol, "Find symbol in workspace", buffer = bufnr },
              e = { vim.diagnostic.open_float, "Show diagnostics for line", buffer = bufnr },
              E = { require("telescope.builtin").diagnostics, "Show diagnostics for buffer", buffer = bufnr },
              F = { vim.lsp.buf.format, "Format buffer", buffer = bufnr },
            },
          })
        '';
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
          onAttach.function =
            /*
            lua
            */
            ''
              require("which-key").register({["<leader>y"] = require("rust_tools").hover_actions.hover_actions, buffer = bufnr })
            '';
          installCargo = false;
          installRustc = false;
        };
      };
    };
  };
}

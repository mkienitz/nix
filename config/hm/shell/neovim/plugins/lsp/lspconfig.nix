{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = lspsaga-nvim;
      opts = {
        lightbulb.enable = false;
      };
    }
    {
      pkg = nvim-lspconfig;
      event = ["BufReadPre" "BufNewFile"];
      dependencies = [
        dressing-nvim
        which-key-nvim
        cmp-nvim-lsp
        nvim-cmp
        telescope-nvim
      ];
      config =
        /*
        lua
        */
        ''
          function()
            -- Prepare keybinds on attach
            local wk = require("which-key")

            local on_attach = function(client, bufnr)
              if client.name == "tailwindcss" then
                require("tailwindcss-colors").buf_attach(bufnr)
              end
              wk.register({
                K = { vim.lsp.buf.hover, "Hover documentation", buffer = bufnr },
                g = {
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
            end

            -- Prepare capabilities and handlers
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            -- Generic LSP handler
            for _, v in ipairs({"hls", "svelte", "typst_lsp", "pyright", "tsserver", "tailwindcss"}) do
              lspconfig[v].setup({
                capabilities = capabilities,
                on_attach = on_attach,
              })
            end

            -- Dedicated handlers
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    library = {
                      [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                      [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                  },
                },
              },
            })

            lspconfig.rust_analyzer.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = {
                ['rust-analyzer'] = {
                  checkOnSave = {
                    command = "clippy",
                  },
                  files = {
                    excludeDirs = { ".direnv" },
                  },
                },
              },
            })

            lspconfig.nil_ls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = {
                ["nil"] = {
                  formatting = {
                    command = { "${(lib.getExe pkgs.alejandra)}", "--quiet" },
                  },
                },
              },
            })
          end
        '';
    }
  ];
}

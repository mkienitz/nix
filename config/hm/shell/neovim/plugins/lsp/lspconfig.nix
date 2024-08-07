{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (config.nixvim.helpers) emptyTable toRawKeys;
  inherit (builtins) map listToAttrs;
  vpkgs = pkgs.vimPlugins;
  on_attach =
    # lua
    ''
      function(client, bufnr)
        -- TODO uncomment once enabled
        -- if client.server_capabilities.inlayHintProvider then
        --   vim.lsp.inlay_hint(bufnr, true)
        -- end
        local wk = require("which-key")
        wk.add({
          { "<leader>K", vim.lsp.buf.hover, desc = "Hover documentation", buffer = bufnr },
          { "<leader>gd", vim.lsp.buf.definition, desc = "Definition", buffer = bufnr },
          { "<leader>gD", vim.lsp.buf.declaration, desc = "Declaration", buffer = bufnr },
          { "<leader>gi", vim.lsp.buf.implementation, desc = "Implementation", buffer = bufnr },
          { "<leader>go", vim.lsp.buf.type_definition, desc = "Type definition", buffer = bufnr },
          { "<leader>gr", vim.lsp.buf.references, desc = "References", buffer = bufnr },
          { "[d", vim.diagnostic.goto_next, desc ="Jump to next diagnostic", buffer = bufnr },
          { "]d", vim.diagnostic.goto_prev, desc ="Jump to previous diagnostic", buffer = bufnr },
          { "<leader>c", vim.lsp.buf.code_action, desc = "Show code actions", buffer = bufnr },
          { "<leader>rn", vim.lsp.buf.rename, desc = "Rename symbol", buffer = bufnr },
          { "<leader>vws", vim.lsp.buf.workspace_symbol, desc = "Find symbol in workspace", buffer = bufnr },
          { "<leader>e", vim.diagnostic.open_float, desc = "Show diagnostics for line", buffer = bufnr },
          { "<leader>E", require("telescope.builtin").diagnostics, "Show diagnostics for buffer", buffer = bufnr },
          { "<leader>F", vim.lsp.buf.format, desc = "Format buffer", buffer = bufnr },
        })
      end
    '';
in {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = vpkgs.crates-nvim;
      dependencies = with vpkgs; [plenary-nvim nvim-cmp];
      opts = {
        lsp = {
          enabled = true;
          actions = true;
          completion = true;
          hover = true;
          on_attach.__raw = on_attach;
        };
        completion.cmp.enabled = true;
      };
    }
    {
      pkg = vpkgs.nvim-lspconfig;
      event = ["BufReadPre" "BufNewFile"];
      dependencies = with vpkgs; [
        dressing-nvim
        which-key-nvim
        cmp-nvim-lsp
        nvim-cmp
        telescope-nvim
        crates-nvim
      ];
      opts = {
        servers =
          # Generic servers
          listToAttrs (map (server_name: {
              name = server_name;
              value = emptyTable;
            }) [
              "gleam"
              "hls"
              "svelte"
              "typst_lsp"
              "pyright"
              "tsserver"
              "tailwindcss"
            ])
          // {
            lua_ls = {
              settings = {
                Lua = {
                  diagnostics.globals = ["vim"];
                  workspace.library = toRawKeys {
                    "vim.fn.expand(\"$VIMRUNTIME/lua\")" = true;
                    "vim.fn.stdpath(\"config\") .. \"/lua\"" = true;
                  };
                };
              };
            };
            nil_ls = {
              settings.nil.formatting.command = ["${(lib.getExe pkgs.alejandra)}" "--quiet"];
            };
            rust_analyzer.settings.rust-analyzer = {
              checkOnSave.command = "clippy";
              files.excludeDirs = [".direnv"];
            };
          };
      };
      config =
        # lua
        ''
          function(_, opts)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            for server_name, server_opts in pairs(opts.servers) do
              server_opts.capabilities = capabilities
              server_opts.on_attach = ${on_attach}
              lspconfig[server_name].setup(server_opts)
            end
          end
        '';
    }
  ];
}

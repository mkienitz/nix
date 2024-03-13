{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = with pkgs.vimPlugins; [
    {
      pkg = nvim-cmp;
      event = "InsertEnter";
      dependencies = [
        cmp-path
        cmp-emoji
        cmp-nvim-lua
        cmp-nvim-lsp-signature-help
        cmp-nvim-lsp-document-symbol
        cmp-nvim-lsp
        luasnip
        cmp_luasnip
        lspkind-nvim
        nvim-autopairs
      ];
      config =
        /*
        lua
        */
        ''
          function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            -- Properly close pairs after selection
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            cmp.setup({
              snippet = {
                expand = function(args)
                  luasnip.lsp_expand(args.body)
                end,
              },
              mapping = cmp.mapping.preset.insert({
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<cr>"] = cmp.mapping.confirm({ select = false }),
                ["<C-cr>"] = cmp.mapping.confirm({ select = true }),
              }),
              sources = {
                { name = "nvim_lsp", group_index = 1 },
                { name = "nvim_lsp_document_symbol", group_index = 1 },
                { name = "nvim_lsp_signature_help", group_index = 1 },
                { name = "emoji", group_index = 2 },
                { name = "luasnip", group_index = 2 },
                { name = "path", group_index = 2 },
              },
              formatting = {
                format = lspkind.cmp_format({
                  mode = "symbol",
                  maxwidth = 50,
                  ellipsis_char = "...",
                }),
              },
            })
          end
        '';
    }
  ];
}
#
# {
#   programs.nixvim = {
#     plugins = {
#       luasnip = {
#         enable = true;
#         extraConfig = {
#           history = true;
#           updateevents = "TextChanged,TextChangedI";
#           enable_autosnippets = true;
#         };
#       };
#       lspkind = {
#         enable = true;
#         cmp = {
#           enable = true;
#           maxWidth = 50;
#           ellipsisChar = "...";
#         };
#       };
#       cmp-cmdline-history.enable = true;
#       cmp-cmdline.enable = true;
#       cmp-emoji.enable = true;
#       cmp-nvim-lsp-document-symbol.enable = true;
#       cmp-nvim-lsp-signature-help.enable = true;
#       cmp-nvim-lsp.enable = true;
#       cmp-path.enable = true;
#       cmp-treesitter.enable = true;
#       cmp_luasnip.enable = true;
#       cmp = {
#         enable = true;
#         settings = {
#           sources = [
#             {name = "emoji";}
#             {name = "luasnip";}
#             {name = "nvim_lsp";}
#             {name = "nvim_lsp_document_symbol";}
#             {name = "nvim_lsp_signature_help";}
#             {name = "path";}
#             {name = "treesitter";}
#           ];
#           mapping = {
#             "<C-f>" = "cmp.mapping.scroll_docs(4)";
#             "<C-d>" = "cmp.mapping.scroll_docs(-4)";
#             "<C-e>" = "cmp.mapping.abort()";
#             "<C-j>" = "cmp.mapping.select_next_item()";
#             "<C-k>" = "cmp.mapping.select_prev_item()";
#             "<CR>" = "cmp.mapping.confirm({ select = false })";
#             "<C-CR>" = "cmp.mapping.confirm({ select = true })";
#           };
#           snippet.expand = ''
#             function(args)
#               require('luasnip').lsp_expand(args.body)
#             end
#           '';
#         };
#       };
#     };
#   };
# }


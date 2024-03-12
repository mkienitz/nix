{
  programs.nixvim = {
    plugins = {
      luasnip = {
        enable = true;
        extraConfig = {
          history = true;
          updateevents = "TextChanged,TextChangedI";
          enable_autosnippets = true;
        };
      };
      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          maxWidth = 50;
          ellipsisChar = "...";
        };
      };
      cmp-cmdline-history.enable = true;
      cmp-cmdline.enable = true;
      cmp-emoji.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-treesitter.enable = true;
      cmp_luasnip.enable = true;
      cmp = {
        enable = true;
        settings = {
          sources = [
            {name = "emoji";}
            {name = "luasnip";}
            {name = "nvim_lsp";}
            {name = "nvim_lsp_document_symbol";}
            {name = "nvim_lsp_signature_help";}
            {name = "path";}
            {name = "treesitter";}
          ];
          mapping = {
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<CR>" = "cmp.mapping.confirm({ select = false })";
            "<C-CR>" = "cmp.mapping.confirm({ select = true })";
          };
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
        };
      };
    };
  };
}

{
  pkgs,
  helpers,
  ...
}: {
  # nvim-cmp
  config = {
    # some functions for snippets
    extraConfigLuaPre = ''
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
    '';
    plugins = {
      luasnip = {
        enable = true;
        fromVscode = [{}];
      };
      cmp-emoji.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-nvim-lua.enable = true;
      # cmp-nvim-ultisnips.enable = true;
      cmp_luasnip.enable = true;
      cmp-path.enable = true;

      lspkind = {
        enable = true;
        mode = "symbol_text";
        cmp = {
          enable = true;
          # Custom Theme
          after = ''
            function(entry, vim_item, kind)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    (" .. (strings[2] or "") .. ")"
                return kind
            end
          '';
        };
      };
      nvim-cmp = {
        enable = true;
        # snippet.expand = "ultisnips";
        snippet.expand = "luasnip";
        sources = [
          {name = "nvim_lsp";}
          {name = "nvim_lsp_document_symbol";}
          {name = "nvim_lsp_signature_help";}
          # {name = "ultisnips";}
          {name = "luasnip";}
          {name = "path";}
          {name = "buffer";}
          {name = "emoji";}
        ];
        window = {
          documentation.maxHeight = "math.floor(40 * (40 / vim.o.lines))";
          completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
            colOffset = -3;
            sidePadding = 0;
          };
        };

        formatting = {
          fields = ["kind" "abbr" "menu"];
        };
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            modes = ["i" "s"];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- they way you will only jump inside the snippet region
                elseif require("luasnip").expand_or_locally_jumpable() then
                  require("luasnip").expand_or_jump()
                elseif has_words_before() then
                  cmp.complete()
                else
                  fallback()
                end
              end
            '';
          };
          "<S-Tab>" = {
            modes = ["i" "s"];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").jumpable(-1) then
                  require("luasnip").jump(-1)
                else
                  fallback()
                end
              end
            '';
          };
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<Up>" = "cmp.mapping.select_prev_item()";
          "<Down>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-u>" = "cmp.mapping.scroll_docs(-4)";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";
        };
      };
    };

    # Snippets
    extraPlugins = with pkgs.vimPlugins; [
      vim-snippets
      friendly-snippets
      # ultisnips
    ];

    # Highlights for custom theme
    colorschemes.catppuccin.customHighlights = {
      PmenuSel = {
        bg = helpers.mkRaw "colors.base";
        fg = "NONE";
      };
      Pmenu = {
        fg = helpers.mkRaw "colors.crust";
        bg = helpers.mkRaw "colors.mantle";
      };
      CmpItemKindSnippet = {
        bg = helpers.mkRaw "colors.mauve";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindKeyword = {
        bg = helpers.mkRaw "colors.red";
        fg = helpers.mkRaw "colors.crust";
      };

      CmpItemKindText = {
        bg = helpers.mkRaw "colors.teal";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindMethod = {
        bg = helpers.mkRaw "colors.blue";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindConstructor = {
        bg = helpers.mkRaw "colors.blue";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindFunction = {
        bg = helpers.mkRaw "colors.blue";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindFolder = {
        bg = helpers.mkRaw "colors.blue";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindModule = {
        bg = helpers.mkRaw "colors.blue";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindConstant = {
        bg = helpers.mkRaw "colors.peach";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindField = {
        bg = helpers.mkRaw "colors.green";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindProperty = {
        bg = helpers.mkRaw "colors.green";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindEnum = {
        bg = helpers.mkRaw "colors.green";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindUnit = {
        bg = helpers.mkRaw "colors.green";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindClass = {
        bg = helpers.mkRaw "colors.yellow";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindVariable = {
        bg = helpers.mkRaw "colors.red";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindFile = {
        bg = helpers.mkRaw "colors.blue";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindInterface = {
        bg = helpers.mkRaw "colors.yellow";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindColor = {
        bg = helpers.mkRaw "colors.red";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindReference = {
        bg = helpers.mkRaw "colors.red";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindEnumMember = {
        bg = helpers.mkRaw "colors.red";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindStruct = {
        bg = helpers.mkRaw "colors.blue";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindValue = {
        bg = helpers.mkRaw "colors.peach";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindEvent = {
        bg = helpers.mkRaw "colors.blue";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindOperator = {
        bg = helpers.mkRaw "colors.blue";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindTypeParameter = {
        bg = helpers.mkRaw "colors.blue";
        fg = helpers.mkRaw "colors.crust";
      };
      CmpItemKindCopilot = {
        bg = helpers.mkRaw "colors.teal";
        fg = helpers.mkRaw "colors.crust";
      };
    };
  };
}

{
  pkgs,
  helpers,
  ...
}: {
  # nvim-cmp
  config = {
    # some functions for snippets
    extraConfigLuaPre = ''
      local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
      local expand_or_jump_forwards = function(fallback)
      	cmp_ultisnips_mappings.compose { "expand", "jump_forwards", "select_next_item" }(fallback)
      end
      local jump_backwards = function(fallback)
      	cmp_ultisnips_mappings.compose { "jump_backwards", "select_prev_item" }(fallback)
      end
    '';
    plugins = {
      cmp-emoji.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-nvim-lua.enable = true;
      cmp-nvim-ultisnips.enable = true;
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
        snippet.expand = "ultisnips";
        sources = [
          {name = "nvim_lsp";}
          {name = "nvim_lsp_document_symbol";}
          {name = "nvim_lsp_signature_help";}
          {name = "ultisnips";}
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
              cmp.mapping(function(fallback)
                expand_or_jump_forwards(fallback)
              end, { "i", "s" })
            '';
          };
          "<S-Tab>" = {
            modes = ["i" "s"];
            action = ''
               cmp.mapping(function(fallback)
                jump_backwards(fallback)
              end, { "i", "s" })
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
      ultisnips
    ];

    # Highlights for custom theme
    colorschemes.catppuccin.customHighlights = {
      PmenuSel = {
        bg = helpers.mkRaw "colors.base";
        fg = "NONE";
      };
      Pmenu = {
        fg = "#FFFFFF";
        bg = helpers.mkRaw "colors.mantle";
      };
      CmpItemKindSnippet = {
        bg = helpers.mkRaw "colors.mauve";
        fg = "#FFFFFF";
      };
      CmpItemKindKeyword = {
        bg = helpers.mkRaw "colors.red";
        fg = "#FFFFFF";
      };
      CmpItemKindText = {
        bg = helpers.mkRaw "colors.teal";
        fg = "#FFFFFF";
      };
      CmpItemKindMethod = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindConstructor = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindFunction = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindFolder = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindModule = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindConstant = {
        bg = helpers.mkRaw "colors.peach";
        fg = "#FFFFFF";
      };
      CmpItemKindField = {
        bg = helpers.mkRaw "colors.green";
        fg = "#FFFFFF";
      };
      CmpItemKindProperty = {
        bg = helpers.mkRaw "colors.green";
        fg = "#FFFFFF";
      };
      CmpItemKindEnum = {
        bg = helpers.mkRaw "colors.green";
        fg = "#FFFFFF";
      };
      CmpItemKindUnit = {
        bg = helpers.mkRaw "colors.green";
        fg = "#FFFFFF";
      };
      CmpItemKindClass = {
        bg = helpers.mkRaw "colors.yellow";
        fg = "#FFFFFF";
      };
      CmpItemKindVariable = {
        bg = helpers.mkRaw "colors.red";
        fg = "#FFFFFF";
      };
      CmpItemKindFile = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindInterface = {
        bg = helpers.mkRaw "colors.yellow";
        fg = "#FFFFFF";
      };
      CmpItemKindColor = {
        bg = helpers.mkRaw "colors.red";
        fg = "#FFFFFF";
      };
      CmpItemKindReference = {
        bg = helpers.mkRaw "colors.red";
        fg = "#FFFFFF";
      };
      CmpItemKindEnumMember = {
        bg = helpers.mkRaw "colors.red";
        fg = "#FFFFFF";
      };
      CmpItemKindStruct = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindValue = {
        bg = helpers.mkRaw "colors.peach";
        fg = "#FFFFFF";
      };
      CmpItemKindEvent = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindOperator = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindTypeParameter = {
        bg = helpers.mkRaw "colors.blue";
        fg = "#FFFFFF";
      };
      CmpItemKindCopilot = {
        bg = helpers.mkRaw "colors.teal";
        fg = "#FFFFFF";
      };
    };
  };
}

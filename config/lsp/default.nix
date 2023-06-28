{helpers, ...}: {
  imports = [./null-ls.nix ./nvim-cmp.nix];
  config = {
    plugins = {
      # Native LSP
      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
          nil_ls.enable = true;
          rust-analyzer.enable = true;
          tsserver.enable = true;
          tailwindcss.enable = true;
          cssls.enable = true;
          astro.enable = true;
        };
      };
      # LSP saga
      lspsaga = {
        enable = true;
        icons.codeAction = "";
        signs = {
          error = "";
          hint = "";
          info = "";
          warning = "";
        };
      };
      emmet = {
        enable = true;
        leader = "<c-z>";
      };
    };
    # LSP Mappings
    maps = {
      # Async LSP Finder
      normal."<leader>gh" = {
        silent = true;
        action = ":Lspsaga lsp_finder<CR>";
      };
      # Code Action
      normal."<leader>la" = {
        silent = true;
        action = ":Lspsaga code_action<CR>";
      };
      visual."<leader>la" = {
        silent = true;
        action = ":<C-U>Lspsaga range_code_action<CR>";
      };
      # Rename
      normal."<leader>lr" = {
        silent = true;
        action = ":Lspsaga rename<CR>";
      };
      # View Definations
      normal."<leader>gd" = {
        silent = true;
        action = ":Lspsaga preview_definition<CR>";
      };

      # Hover
      normal."<leader>lk" = {
        silent = true;
        action = "<cmd>Lspsaga hover_doc<cr>";
      };
      normal."K" = {
        silent = true;
        action = "<cmd>Lspsaga hover_doc<cr>";
      };
      normal."<leader>ll" = {
        silent = true;
        action = "<cmd>Lspsaga show_line_diagnostics<cr>";
        desc = "Show Line Diagnostic";
      };

      # Move Between Errors
      normal."[e" = {
        silent = true;
        action = ''
          function()
            require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end
        '';
        desc = "Previous Error";
      };

      normal."]e" = {
        silent = true;
        action = ''
          function()
            require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
          end
        '';
        desc = "Next Error";
      };
    };
  };
}

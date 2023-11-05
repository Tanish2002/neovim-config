{
  helpers,
  pkgs,
  ...
}: {
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
          volar.enable = true;
          lua-ls = {
            enable = true;
            settings = {
              workspace.library = [
                (helpers.mkRaw "vim.api.nvim_get_runtime_file(\"\", true)")
                "${pkgs.awesome}/share/awesome/lib"
              ];
            };
          };
          omnisharp.enable = true;
          pyright.enable = true;
        };
      };
      # LSP saga
      lspsaga.enable = true;

      # Emmet
      emmet = {
        enable = true;
        leader = "<c-z>";
      };
    };
    # LSP Mappings
    maps = {
      # Async LSP Finder
      normal."<leader>lf" = {
        silent = true;
        action = ":Lspsaga finder def+ref<CR>";
        desc = "Lspsaga Finder";
      };
      # Call hierarchy
      normal."<leader>lci" = {
        silent = true;
        action = ":Lspsaga incoming_calls<CR>";
        desc = "Lspsaga Incoming Calls";
      };
      normal."<leader>lco" = {
        silent = true;
        action = ":Lspsaga outgoing_calls<CR>";
        desc = "Lspsaga Outgoing Calls";
      };
      # Code Action
      normal."<leader>la" = {
        silent = true;
        action = ":Lspsaga code_action<CR>";
        desc = "Code Action";
      };
      visual."<leader>la" = {
        silent = true;
        "action" = ":<C-U>Lspsaga range_code_action<CR>";
        desc = "Code Action";
      };
      # Rename
      normal."<leader>lr" = {
        silent = true;
        action = ":Lspsaga rename<CR>";
        desc = "LSP Rename";
      };
      # Peek Definations
      normal."<leader>lpd" = {
        silent = true;
        action = ":Lspsaga peek_definition<CR>";
        desc = "Peek Defination";
      };
      normal."<leader>lpt" = {
        silent = true;
        action = ":Lspsaga peek_type_definition<CR>";
        desc = "Peek Defination";
      };
      # Goto
      normal."gD" = {
        silent = true;
        action = "<Cmd>lua vim.lsp.buf.declaration()<CR>";
        desc = "Goto Declaration";
      };
      normal."gd" = {
        silent = true;
        action = "<Cmd>:Lspsaga goto_definition<CR>";
        desc = "Goto Defination";
      };
      normal."gi" = {
        silent = true;
        action = "<Cmd>lua vim.lsp.buf.implementation()<CR>";
        desc = "Goto Implementation";
      };
      # LSP Outline
      normal."<leader>lo" = {
        silent = true;
        action = "<Cmd>Lspsaga outline<CR>";
        desc = "LSP Outline";
      };
      # Workspace
      normal."<space>wa" = {
        silent = true;
        action = "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>";
        desc = "Add folder to workspace";
      };
      normal."<space>wr" = {
        silent = true;
        action = "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>";
        desc = "Remove folder to workspace";
      };
      normal."<space>wl" = {
        silent = true;
        action = ''
          function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end
        '';
        lua = true;
        desc = "Show all workspace folders";
      };
      # Hover
      normal."<leader>lk" = {
        silent = true;
        action = "<Cmd>Lspsaga hover_doc<CR>";
        desc = "Hover Info";
      };
      normal."K" = {
        silent = true;
        action = "<Cmd>Lspsaga hover_doc<CR>";
        desc = "Hover Info";
      };
      normal."<leader>ll" = {
        silent = true;
        action = "<Cmd>Lspsaga show_line_diagnostics<CR>";
        desc = "Show Line Diagnostic";
      };

      # Move Between Diagnostics
      normal."[d" = {
        silent = true;
        action = "<Cmd>lua vim.diagnostic.goto_prev()<CR>";
        desc = "Previous Diagnostic";
      };

      normal."]d" = {
        silent = true;
        action = "<Cmd>lua vim.diagnostic.goto_next()<CR>";
        desc = "Next Diagnostic";
      };
    };
  };
}

{pkgs, ...}: {
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
      normal."<leader>lr" = {action = ":Lspsaga rename<CR>";};
      # View Definations
      normal."<leader>gd" = {action = ":Lspsaga preview_definition<CR>";};
    };
  };
}

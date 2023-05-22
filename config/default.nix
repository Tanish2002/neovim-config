{
  pkgs,
  helpers,
  ...
}: {
  imports = [./lsp ./misc ./lualine ./tree ./barbar ./telescope ./which-key ./alpha];
  config = {
    colorschemes.catppuccin = {
      enable = true;
      terminalColors = true;
      disableItalic = false;
      disableBold = false;
    };
    plugins = {
      treesitter = {
        enable = true;
        ensureInstalled = [
          "go"
          "rust"
          "nix"
          "lua"
          "haskell"
          "java"
        ];
        folding = true;
        indent = true;
        nixGrammars = true;
        nixvimInjections = true;
      };
      project-nvim.enable = true;
    };
    globals.mapleader = " "; # Sets the leader key to space
    options = {
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers
      guifont = "Iosevka Nerd Font Mono:h8";
      clipboard = "unnamedplus";
      timeout = true;
      timeoutlen = 300;
      smarttab = true;
      foldenable = false;
    };
    globals = {
      # neovide_padding_top = 50;
      # neovide_padding_bottom = 50;
      # neovide_padding_right = 50;
      # neovide_padding_left = 50;
    };
  };
}

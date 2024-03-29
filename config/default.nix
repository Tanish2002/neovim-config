{...}: {
  imports = [./lsp ./misc ./telescope ./which-key ./ui ./tmux];
  config = {
    colorschemes.catppuccin = {
      enable = true;
      terminalColors = true;
      disableItalic = false;
      disableBold = false;
    };
    luaLoader.enable = true;
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
          "html"
          "astro"
          "javascript"
          "python"
        ];
        folding = true;
        indent = true;
        nixGrammars = true;
        nixvimInjections = true;
      };
      ts-autotag.enable = true;
      project-nvim.enable = true;
      auto-session.enable = true;
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
      tabstop = 2;
      shiftwidth = 2;
      autoindent = true;
      cindent = true;
      smartindent = true;
      smartcase = true;
      ignorecase = true;
      infercase = true;
      showmode = false;
      ruler = false;
      showcmd = false;
      breakindent = true;
      copyindent = true;
      cursorline = true;
      expandtab = true;
      preserveindent = true;
      pumheight = 10;
      undofile = true;
      virtualedit = "block";
      wrap = false;
      titlestring = "neovim";
      title = true;
      splitbelow = true;
      splitright = true;
    };
  };
}

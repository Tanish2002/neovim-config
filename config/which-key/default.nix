_: {
  config.plugins.which-key = {
    enable = true;
    disable.filetypes = [ "TelescopePrompt" ];
    icons = {
      group = "";
      separator = "";
    };
    registrations = {
      "<leader>g" = " Git";
      "<leader>f" = " Files";
      "<leader>b" = " Buffer";
      "<leader>t" = " Terminal";
      "<leader>l" = " LSP";
    };
  };
}

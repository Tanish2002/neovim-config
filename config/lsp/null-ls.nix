{...}: {
  config.plugins.null-ls = {
    enable = true;
    cmd = ["bash -c nvim"];
    debug = true;
    sources = {
      code_actions = {
        statix.enable = true;
      };
      diagnostics = {
        statix.enable = true;
        deadnix.enable = true;
        # mypy.enable = true;
      };
      formatting = {
        alejandra.enable = true;
        stylua.enable = true;
        shfmt.enable = true;
        nixpkgs_fmt.enable = true;
        prettier.enable = true;
        black.enable = true;
      };
    };
  };
}

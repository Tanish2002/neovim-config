_: {
  config = {
    plugins = {
      toggleterm = {
        enable = true;
        openMapping = "<c-\\>";
      };
    };

    maps = {
      normal = {
        "<leader>tf" = {
          action = "<cmd>ToggleTerm direction=float<cr>";
          silent = true;
          desc = "ToggleTerm float";
        };
        "<leader>th" = {
          action = "<cmd>ToggleTerm size=10 direction=horizontal<cr>";
          silent = true;
          desc = "ToggleTerm horizontal split";
        };
        "<leader>tv" = {
          action = "<cmd>ToggleTerm size=80 direction=vertical<cr>";
          silent = true;
          desc = "ToggleTerm vertical split";
        };
        "<c-\\>" = {
          action = "<cmd>ToggleTerm<cr>";
          silent = true;
          desc = "Toggle terminal";
        };
      };
    };
  };
}

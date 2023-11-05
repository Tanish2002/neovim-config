_: {
  config = {
    plugins = {
      toggleterm = {
        enable = true;
        openMapping = "<c-\\>";
      };
    };

    keymaps = [
      {
        key = "<leader>tf";
        mode = ["n"];
        action = "<cmd>ToggleTerm direction=float<cr>";
        options = {
          silent = true;
          desc = "ToggleTerm float";
        };
      }
      {
        key = "<leader>th";
        mode = ["n"];
        action = "<cmd>ToggleTerm size=10 direction=horizontal<cr>";
        options = {
          silent = true;
          desc = "ToggleTerm horizontal split";
        };
      }
      {
        key = "<leader>tv";
        mode = ["n"];
        action = "<cmd>ToggleTerm size=80 direction=vertical<cr>";
        options = {
          silent = true;
          desc = "ToggleTerm vertical split";
        };
      }
      {
        key = "<c-\\>";
        mode = ["n"];
        action = "<cmd>ToggleTerm<cr>";
        options = {
          silent = true;
          desc = "Toggle terminal";
        };
      }
    ];
  };
}

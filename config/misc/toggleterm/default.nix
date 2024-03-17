_: {
  config = {
    plugins = {
      toggleterm = {
        enable = true;
        # I already use tmux so.. I rarely use this but useful in a non tmux session
        openMapping = "<c-t>";
      };
    };

    keymaps = [
      {
        key = "<leader>tf";
        mode = [ "n" ];
        action = "<cmd>ToggleTerm direction=float<cr>";
        options = {
          silent = true;
          desc = "ToggleTerm float";
        };
      }
      {
        key = "<leader>th";
        mode = [ "n" ];
        action = "<cmd>ToggleTerm size=10 direction=horizontal<cr>";
        options = {
          silent = true;
          desc = "ToggleTerm horizontal split";
        };
      }
      {
        key = "<leader>tv";
        mode = [ "n" ];
        action = "<cmd>ToggleTerm size=80 direction=vertical<cr>";
        options = {
          silent = true;
          desc = "ToggleTerm vertical split";
        };
      }
      {
        key = "<c-t>";
        mode = [ "n" ];
        action = "<cmd>ToggleTerm<cr>";
        options = {
          silent = true;
          desc = "Toggle terminal";
        };
      }
    ];
  };
}

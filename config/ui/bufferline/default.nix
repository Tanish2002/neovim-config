{...}: {
  config = {
    plugins.barbar = {
      enable = true;
      animation = true;
      clickable = true;
      semanticLetters = true;
      excludeFileNames = ["alpha"];
      icons = {
        button = "";
        diagnostics = {
          error = {
            enable = true;
            icon = "ﬀ";
          };
          hint.enable = true;
        };
        filetype = {
          enable = true;
          customColors = true;
        };
        modified.button = "●";
        pinned.button = "";
        inactive.button = "×";
      };
      maximumPadding = 1;
      minimumPadding = 1;
      maximumLength = 30;
      sidebarFiletypes = {
        "neo-tree" = {
          event = "BufWipeout";
        };
      };
    };
    keymaps = [
      {
        key = "]b";
        mode = ["n"];
        action = "<cmd>BufferNext<cr>";
        options = {
          silent = true;
          desc = "Next Buffer";
        };
      }
      {
        key = "[b";
        mode = ["n"];
        action = "<cmd>BufferPrevious<cr>";
        options = {
          silent = true;
          desc = "Previous Buffer";
        };
      }
      # Pin/unpin buffer
      {
        key = "<leader>bp";
        mode = ["n"];
        action = "<cmd>BufferPin<cr>";
        options = {
          silent = true;
          desc = "Pin Buffer";
        };
      }
      {
        key = "<leader>br";
        mode = ["n"];
        action = "<cmd>BufferRestore<cr>";
        options = {
          silent = true;
          desc = "Restore Buffer";
        };
      }
      {
        key = "<leader>bc";
        mode = ["n"];
        action = "<cmd>BufferCloseAllButCurrent<cr>";
        options = {
          silent = true;
          desc = "Close all Buffers except Current";
        };
      }
      {
        key = "<leader>bC";
        mode = ["n"];
        action = "<cmd>BufferWipeout<cr>";
        options = {
          silent = true;
          desc = "Close all Buffers";
        };
      }
      {
        key = "<leader>bd";
        mode = ["n"];
        action = "<cmd>BufferPickDelete<cr>";
        options = {
          silent = true;
          desc = "Pick Buffer to Close";
        };
      }
      {
        key = "<leader>c";
        mode = ["n"];
        action = "<cmd>BufferClose<cr>";
        options = {
          silent = true;
          desc = "Close Buffer";
        };
      }
    ];
  };
}

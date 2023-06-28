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
    maps.normal = {
      "]b" = {
        action = "<cmd>BufferNext<cr>";
        silent = true;
        desc = "Next Buffer";
      };
      "[b" = {
        action = "<cmd>BufferPrevious<cr>";
        silent = true;
        desc = "Previous Buffer";
      };
      "<leader>b" = {
        desc = " Buffer";
      };
      # Pin/unpin buffer
      "<leader>bp" = {
        action = "<cmd>BufferPin<cr>";
        silent = true;
        desc = "Pin Buffer";
      };
      "<leader>br" = {
        action = "<cmd>BufferRestore<cr>";
        silent = true;
        desc = "Restore Buffer";
      };
      "<leader>bc" = {
        action = "<cmd>BufferCloseAllButCurrent<cr>";
        silent = true;
        desc = "Close all Buffers except Current";
      };
      "<leader>bC" = {
        action = "<cmd>BufferWipeout<cr>";
        silent = true;
        desc = "Close all Buffers";
      };
      "<leader>bd" = {
        action = "<cmd>BufferPickDelete<cr>";
        silent = true;
        desc = "Pick Buffer to Close";
      };
      "<leader>c" = {
        action = "<cmd>BufferClose<cr>";
        silent = true;
        desc = "Close Buffer";
      };
    };
  };
}

{...}: {
  config = {
    plugins.neo-tree = {
      enable = true;
      enableDiagnostics = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;
      autoCleanAfterSessionRestore = true;
      sourceSelector = {
        winbar = true;
        contentLayout = "focus";
        sources = [
          {
            source = "filesystem";
            displayName = " File";
          }
          {
            source = "buffers";
            displayName = " Buffer";
          }
          {
            source = "git_status";
            displayName = " Git";
          }
          {
            source = "diagnostics";
            displayName = " Diagnostics";
          }
        ];
      };
      defaultComponentConfigs = {
        indent = {
          padding = 0;
          indentSize = 1;
        };
        icon = {
          folderClosed = "";
          folderOpen = "";
          folderEmpty = "";
          default = "";
        };
        modified.symbol = "";
        gitStatus.symbols = {
          added = "";
          deleted = "";
          modified = "";
          renamed = "➜";
          untracked = "★";
          ignored = "◌";
          unstaged = "✗";
          staged = "✓";
          conflict = "";
        };
      };
      closeIfLastWindow = true;
      window.width = 30;
      filesystem = {
        bindToCwd = true;
        followCurrentFile = true;
        useLibuvFileWatcher = true;
      };
      buffers = {
        bindToCwd = true;
        followCurrentFile = true;
      };
    };
    maps.normal = {
      "<leader>e" = {
        action = "<cmd>Neotree toggle<cr>";
        desc = "Neotree toggle";
      };
      "<leader>o" = {
        action = ''
          function()
            if vim.bo.filetype == "neo-tree" then
              vim.cmd.wincmd "p"
            else
              vim.cmd.Neotree "focus"
            end
          end
        '';
        lua = true;
        desc = "Neotree toggle focus";
      };
    };
  };
}

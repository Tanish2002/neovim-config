{pkgs, ...}: {
  imports = [./toggleterm];
  config = {
    extraPlugins = with pkgs.vimPlugins; [vim-wakatime];
    plugins = {
      nvim-autopairs = {
        enable = true;
        checkTs = true;
      };
      comment-nvim = {
        enable = true;
        mappings.extended = true;
      };
      nvim-colorizer = {
        enable = true;
        userDefaultOptions = {
          tailwind = true;
          sass.enable = true;
        };
      };
      presence-nvim = {
        enable = true;
        enableLineNumber = true;
      };
    };
    autoCmd = [
      {
        event = ["TextYankPost"];
        command = "lua vim.highlight.on_yank()";
      }
      {
        event = ["BufWritePre"];
        command = "lua vim.lsp.buf.format()";
      }
    ];
    maps = {
      normal = {
        "<leader>/" = {
          action = ''function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end'';
          silent = true;
          lua = true;
          desc = "Comment line";
        };
        "<leader>w" = {
          action = "<cmd>write<cr>";
          silent = true;
          desc = "Write";
        };
        "<leader>q" = {
          action = "<cmd>quit<cr>";
          silent = true;
          desc = "Quit";
        };
        "<leader>Q" = {
          action = "<cmd>quit!<cr>";
          silent = true;
          desc = "Force Quit";
        };
      };
      visual = {
        "<leader>/" = {
          action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>";
          silent = true;
          desc = "Comment line";
        };
      };
    };
  };
}

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
          css = true;
        };
      };
      presence-nvim = {
        enable = true;
        enableLineNumber = true;
      };
      surround.enable = true;
      # hardtime.enable = true;
      leap.enable = true;
    };
    autoCmd = [
      {
        event = ["TextYankPost"];
        command = "lua vim.highlight.on_yank()";
      }
      # {
      #   event = ["BufWritePre"];
      #   command = "lua vim.lsp.buf.format({async = true})";
      # }
    ];
    keymaps = [
      # Comment Line
      {
        key = "<leader>/";
        mode = ["n"];
        action = ''function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end'';
        lua = true;
        options = {
          silent = true;
          desc = "Comment line";
        };
      }
      {
        key = "<leader>/";
        mode = ["v"];
        action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>";
        options = {
          silent = true;
          desc = "Comment line";
        };
      }
      # Quality of life changes
      {
        key = "<leader>w";
        mode = ["n"];
        action = "<cmd>write<cr>";
        options = {
          silent = true;
          desc = "Write";
        };
      }

      {
        key = "<leader>q";
        mode = ["n"];
        action = "<cmd>quit<cr>";
        options = {
          silent = true;
          desc = "Quit";
        };
      }
      {
        key = "<leader>Q";
        mode = ["n"];
        action = "<cmd>quit!<cr>";
        options = {
          silent = true;
          desc = "Force Quit";
        };
      }
      {
        key = "E";
        mode = ["n"];
        action = "$";
        options = {
          noremap = true;
        };
      }
      {
        key = "B";
        mode = ["n"];
        action = "^";
        options = {
          noremap = true;
        };
      }
      # Splits
      {
        key = "<c-w>,";
        mode = ["n"];
        action = ":vertical resize -10<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        key = "<c-w>.";
        mode = ["n"];
        action = ":vertical resize +10<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      # Word wrap things
      {
        key = "k";
        mode = ["n"];
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          silent = true;
          expr = true;
        };
      }
      {
        key = "j";
        mode = ["n"];
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          silent = true;
          expr = true;
        };
      }
    ];
  };
}

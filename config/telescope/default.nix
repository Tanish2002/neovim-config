{ helpers, ... }: {
  config = {
    plugins = {
      telescope = {
        enable = true;
        extraOptions = {
          pickers.colorscheme.enable_preview = true;
          file_ignore_patterns = [ "node_modules" ];
        };
        defaults = {
          prompt_prefix = " ";
          selection_caret = "❯ ";
          path_display = [
            "truncate"
          ];
          sorting_strategy = "ascending";
          layout_config = {
            horizontal = {
              prompt_position = "top";
              preview_width = 0.55;
            };
            vertical = {
              mirror = false;
            };
            width = 0.87;
            height = 0.80;
            preview_cutoff = 120;
          };
        };
      };
      project-nvim.enableTelescope = true;
    };

    colorschemes.catppuccin.customHighlights = {
      TelescopeBorder = {
        fg = helpers.mkRaw "colors.mantle";
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopeNormal = {
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopePreviewBorder = {
        fg = helpers.mkRaw "colors.crust";
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopePreviewNormal = {
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopePreviewTitle = {
        fg = helpers.mkRaw "colors.crust";
        bg = helpers.mkRaw "colors.green";
      };
      TelescopePromptBorder = {
        fg = helpers.mkRaw "colors.mantle";
        bg = helpers.mkRaw "colors.mantle";
      };
      TelescopePromptNormal = {
        fg = helpers.mkRaw "colors.text";
        bg = helpers.mkRaw "colors.mantle";
      };
      TelescopePromptPrefix = {
        fg = helpers.mkRaw "colors.red";
        bg = helpers.mkRaw "colors.mantle";
      };
      TelescopePromptTitle = {
        fg = helpers.mkRaw "colors.crust";
        bg = helpers.mkRaw "colors.red";
      };
      TelescopeResultsBorder = {
        fg = helpers.mkRaw "colors.crust";
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopeResultsNormal = {
        bg = helpers.mkRaw "colors.crust";
      };
      TelescopeResultsTitle = {
        fg = helpers.mkRaw "colors.crust";
        bg = helpers.mkRaw "colors.crust";
      };
    };
    keymaps = [
      {
        key = "<leader>f<cr>";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").resume() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Resume previous search";
        };
      }
      {
        key = "<leader><leader>";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").find_files() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Find Files";
        };
      }
      {
        key = "<leader>ff";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").find_files() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Find Files";
        };
      }
      {
        key = "<leader>fF";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end'';
        lua = true;
        options = {
          silent = true;
          desc = "Find all Files";
        };
      }
      {
        key = "<leader>fw";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").live_grep() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Find Words";
        };
      }
      {
        key = "<leader>fW";
        mode = [ "n" "v" ];
        action = ''
          function()
            require("telescope.builtin").live_grep {
              additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
            }
          end
        '';
        lua = true;
        options = {
          silent = true;
          desc = "Find Words";
        };
      }
      {
        key = "<leader>fb";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").buffers() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Find Buffers";
        };
      }
      {
        key = "<leader>fc";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").grep_string() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Find word under Cursor";
        };
      }
      {
        key = "<leader>fC";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").commands() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Find Commands";
        };
      }
      {
        key = "<leader>fk";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").keymaps() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Find keymaps";
        };
      }
      {
        key = "<leader>ft";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").colorscheme { enable_preview = true } end'';
        lua = true;
        options = {
          silent = true;
          desc = "Find themes";
        };
      }
      {
        key = "<leader>fn";
        mode = [ "n" "v" ];
        action = ''function() require("telescope").extensions.notify.notify() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Find notifications";
        };
      }
      {
        key = "<leader>fp";
        mode = [ "n" "v" ];
        action = "<cmd>Telescope projects<cr>";
        options = {
          silent = true;
          desc = "Find projects";
        };
      }
      {
        key = "<leader>gb";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").git_branches() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Git branches";
        };
      }
      {
        key = "<leader>gc";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").git_commits() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Git commits";
        };
      }
      {
        key = "<leader>gt";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").git_status() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Git status";
        };
      }
      {
        key = "<leader>lD";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").diagnostics() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Search diagnostics";
        };
      }
      {
        key = "<leader>ls";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").lsp_document_symbols() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Search symbols";
        };
      }
      {
        key = "<leader>,";
        mode = [ "n" "v" ];
        action = ''function() require("telescope.builtin").buffers() end'';
        lua = true;
        options = {
          silent = true;
          desc = "Switch Buffers";
        };
      }
    ];
  };
}

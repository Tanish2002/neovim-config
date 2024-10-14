{ pkgs
, helpers
, ...
}: {
  imports = [ ./toggleterm ];
  config = {
    extraConfigLuaPre = ''
      local harpoon = require('harpoon')
      harpoon:setup({})
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
              table.insert(file_paths, item.value)
          end

          require("telescope.pickers").new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                  results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
          }):find()
      end
    '';
    extraPlugins = with pkgs.vimPlugins; [ vim-wakatime vim-repeat ];
    plugins = {
      nvim-autopairs = {
        enable = true;
        settings.check_ts = true;
      };
      comment.enable = true;
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
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymaps = {
          addFile = "<leader>a";
          cmdToggleQuickMenu = "<c-e>";
        };
      };
      sleuth.enable = true;
      sleuth.settings.no_filetype_indent_on = true;
      nvim-ufo = {
        enable = true;
        providerSelector = ''
          function(_, filetype, buftype)
            local function handleFallbackException(bufnr, err, providerName)
              if type(err) == "string" and err:match "UfoFallbackException" then
                return require("ufo").getFolds(bufnr, providerName)
              else
                return require("promise").reject(err)
              end
            end

            return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
              or function(bufnr)
                return require("ufo")
                  .getFolds(bufnr, "lsp")
                  :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
                  :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
            end
          end
        '';
        enableGetFoldVirtText = true;
        foldVirtTextHandler = ''
          function(virtText, lnum, endLnum, width, truncate)
              local newVirtText = {}
              local suffix = (' 󰁂 %d '):format(endLnum - lnum)
              local sufWidth = vim.fn.strdisplaywidth(suffix)
              local targetWidth = width - sufWidth
              local curWidth = 0
              for _, chunk in ipairs(virtText) do
                  local chunkText = chunk[1]
                  local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                  if targetWidth > curWidth + chunkWidth then
                      table.insert(newVirtText, chunk)
                  else
                      chunkText = truncate(chunkText, targetWidth - curWidth)
                      local hlGroup = chunk[2]
                      table.insert(newVirtText, {chunkText, hlGroup})
                      chunkWidth = vim.fn.strdisplaywidth(chunkText)
                      -- str width returned from truncate() may less than 2nd argument, need padding
                      if curWidth + chunkWidth < targetWidth then
                          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                      end
                      break
                  end
                  curWidth = curWidth + chunkWidth
              end
              table.insert(newVirtText, {suffix, 'MoreMsg'})
              return newVirtText
          end
        '';
      };
      indent-blankline = {
        enable = true;
        settings = {
          exclude = {
            buftypes = [
              "terminal"
              "quickfix"
              "nofile"
              "prompt"
            ];
            filetypes = [
              "alpha"
              "checkhealth"
              "help"
              "lspinfo"
              "TelescopePrompt"
              "TelescopeResults"
              "neo-tree"
              "toggleterm"
            ];
          };
          indent = {
            char = "│";
          };
          scope = {
            show_end = false;
            show_exact_scope = true;
            show_start = false;
          };
        };
      };
      statuscol = {
        enable = true;
        settings = {
          setopt = true;
          segments = [
            {
              click = "v:lua.ScFa";
              text = [ (helpers.mkRaw "require('statuscol.builtin').foldfunc") ];
            }
            {
              click = "v:lua.ScSa";
              text = [ "%s" ];
            }
            {
              click = "v:lua.ScLa";
              condition = [ true (helpers.mkRaw "require('statuscol.builtin').not_empty") ];
              text = [ (helpers.mkRaw "require('statuscol.builtin').lnumfunc") " " ];
            }
          ];
        };
      };
    };
    autoCmd = [
      {
        event = [ "TextYankPost" ];
        command = "lua vim.highlight.on_yank()";
      }
    ];
    keymaps = [
      # Harpoon
      {
        key = "<leader>a";
        mode = [ "n" ];
        action = ''<cmd>lua require("harpoon.mark").add_file()<cr>'';
        options = {
          silent = true;
          desc = "Add file to harpoon";
        };
      }
      {
        key = "<C-e>";
        mode = [ "n" ];
        action = ''<cmd>Telescope harpoon marks<cr>'';
        options = {
          silent = true;
          desc = "Open Harpoon window";
        };
      }
      # Comment Line
      {
        key = "<leader>/";
        mode = [ "n" ];
        action.__raw = ''function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end'';
        options = {
          silent = true;
          desc = "Comment line";
        };
      }
      {
        key = "<leader>/";
        mode = [ "v" ];
        action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>";
        options = {
          silent = true;
          desc = "Comment line";
        };
      }
      # Quality of life changes
      {
        key = "<leader>w";
        mode = [ "n" ];
        action = "<cmd>write<cr>";
        options = {
          silent = true;
          desc = "Write";
        };
      }

      {
        key = "<leader>q";
        mode = [ "n" ];
        action = "<cmd>quit<cr>";
        options = {
          silent = true;
          desc = "Quit";
        };
      }
      {
        key = "<leader>Q";
        mode = [ "n" ];
        action = "<cmd>quit!<cr>";
        options = {
          silent = true;
          desc = "Force Quit";
        };
      }
      {
        key = "E";
        mode = [ "n" ];
        action = "$";
        options = {
          noremap = true;
        };
      }
      {
        key = "B";
        mode = [ "n" ];
        action = "^";
        options = {
          noremap = true;
        };
      }
      # Splits
      {
        key = "<c-w>,";
        mode = [ "n" ];
        action = ":vertical resize -10<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        key = "<c-w>.";
        mode = [ "n" ];
        action = ":vertical resize +10<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      # Word wrap things
      {
        key = "k";
        mode = [ "n" ];
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          silent = true;
          expr = true;
        };
      }
      {
        key = "j";
        mode = [ "n" ];
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          silent = true;
          expr = true;
        };
      }
      # Nvim-UFO
      {
        key = "zR";
        mode = [ "n" ];
        action = "<cmd>lua require('ufo').openAllFolds()<cr>";
        options = {
          silent = true;
        };
      }
      {
        key = "zM";
        mode = [ "n" ];
        action = "<cmd>lua require('ufo').closeAllFolds()<cr>";
        options = {
          silent = true;
        };
      }
    ];
  };
}

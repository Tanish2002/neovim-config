{ pkgs, ... }:
let
  vscode-js-debug = pkgs.buildNpmPackage rec {
    pname = "vscode-js-debug";
    version = "1.88.0";

    src = pkgs.fetchFromGitHub {
      owner = "microsoft";
      repo = "vscode-js-debug";
      rev = "v${version}";
      hash = "sha256-gmeuRUcdz/4+FtPOblNj5DX3otXNRjHJjhPcCRuWXAY=";
    };

    npmDepsHash = "sha256-M4h2p8GLVjBDla0ile1jKWF6wPSdgcumx2GKm9KGmlw=";

    nativeBuildInputs = with pkgs; [ pkg-config nodePackages.node-gyp ];

    buildInputs = with pkgs; [ libsecret ];

    postPatch = ''
      ${pkgs.jq}/bin/jq '
        .scripts.postinstall |= empty |             # tries to install playwright, not necessary for build
        .scripts.build |= "gulp dapDebugServer" |   # there is no build script defined
        .bin |= "./dist/src/dapDebugServer.js"      # there is no bin output defined
      ' ${src}/package.json > package.json
    '';

    makeCacheWritable = true;

    npmInstallFlags = [ "--include=dev" ];

    preBuild = ''
      export PATH="node_modules/.bin:$PATH"
    '';
  };
in
{
  plugins.dap = {
    enable = true;
    extensions = {
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
    };
    adapters = {
      executables.firefox = {
        command = "${pkgs.nodejs}/bin/node";
        args = [ "${pkgs.vscode-extensions.firefox-devtools.vscode-firefox-debug}/share/vscode/extensions/firefox-devtools.vscode-firefox-debug/dist/adapter.bundle.js" ];
      };
      servers.pwa-node = {
        host = "127.0.0.1";
        port = "\${port}";
        executable = {
          command = "${vscode-js-debug}/bin/js-debug";
          args = [ "\${port}" ];
        };
      };
    };
  };

  extraConfigLuaPost = ''
    local js_based_languages = { "typescript", "javascript", "typescriptreact" }

    for _, language in ipairs(js_based_languages) do
      require("dap").configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "''${file}",
          cwd = "''${workspaceFolder}",
        },
        {
         type = 'pwa-node',
         request = 'attach',
         name = 'Attach to Node app',
         address = 'localhost',
         port = 9229,
         cwd = "''${workspaceFolder}",
         restart = true,
        },
        {
          name = 'Debug with Firefox',
          type = 'firefox',
          request = 'launch',
          reAttach = true,
          url = 'http://localhost:3000',
          webRoot = "''${workspaceFolder}",
          firefoxExecutable = 'firefox'
        }
      }
    end

    local dap, dapui = require("dap"), require("dapui")

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end

    require('telescope').load_extension('dap')
  '';

  extraPlugins = [
    pkgs.vimPlugins.telescope-dap-nvim
  ];
  keymaps = [
    # Nvim Dap
    {
      key = "<leader>du";
      mode = [ "n" ];
      action = "<cmd>lua require('dapui').toggle()<cr>";
      options = {
        desc = "Dap UI";
      };
    }
    {
      key = "<F5>";
      mode = [ "n" ];
      action = "<cmd>lua require('dap').continue()<cr>";
      options = {
        desc = "Dap continue";
      };
    }
    {
      key = "<F10>";
      mode = [ "n" ];
      action = "<cmd>lua require('dap').step_over()<cr>";
      options = {
        desc = "Dap Step Over";
      };
    }
    {
      key = "<F11>";
      mode = [ "n" ];
      action = "<cmd>lua require('dap').step_into()<cr>";
      options = {
        desc = "Dap Step Into";
      };
    }
    {
      key = "<F12>";
      mode = [ "n" ];
      action = "<cmd>lua require('dap').step_out()<cr>";
      options = {
        desc = "Dap Step Out";
      };
    }
    {
      key = "<leader>db";
      mode = [ "n" ];
      action = "<cmd>lua require('dap').toggle_breakpoint()<cr>";
      options = {
        desc = "Dap Toggle Breakpoint";
      };
    }
    {
      key = "<leader>dB";
      mode = [ "n" ];
      action.__raw = ''
        function()
          require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end
      '';
      options = {
        desc = "Dap Conditional Breakpoint";
      };
    }
  ];
}

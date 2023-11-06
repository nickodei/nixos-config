{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.nvim;

  lsp_config =
    let context = builtins.readFile ./plugins/lsp.lua;
    in builtins.replaceStrings [ "OMNISHARP_PATH" ] [ "${pkgs.omnisharp-roslyn}/bin/OmniSharp" ] context;
in
{
  options.modules.nvim = { enable = lib.mkEnableOption "nvim"; };

  config = lib.mkIf cfg.enable
    {
      programs.neovim = {
        enable = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        extraPackages = with pkgs; [
          # telescope
          ripgrep
          fd

          # lsp
          lua-language-server
          rnix-lsp
          omnisharp-roslyn
          clang-tools_16

          # debuggers
          netcoredbg
        ];

        plugins = with pkgs.vimPlugins; [
          {
            plugin = telescope-nvim;
            type = "lua";
            config = ''
              local
              builtin = require('telescope.builtin')
              vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
              vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
              vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
              vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            '';
          }
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config = lsp_config;
          }
          {
            plugin = nvim-cmp;
            type = "lua";
            config = builtins.readFile ./plugins/cmp.lua;
          }
          {
            plugin = lualine-nvim;
            type = "lua";
            config = ''
              require("lualine").setup({
                icons_enabled = true,
                theme = 'onedark',
              })
            '';
          }
          {
            plugin = nvim-dap;
            type = "lua";
            config = ''
                local dap = require("dap")

                dap.adapters.coreclr = {
                  type = 'executable',
                  command = '${pkgs.netcoredbg}/bin/netcoredbg',
                  args = {'--interpreter=vscode'}
                }

                dap.configurations.cs = {
                {
                  type = "coreclr",
                  name = "launch - netcoredbg",
                  request = "launch",
                  program = function()
                      return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                  end,
                },
              }

              vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticDefaultError' })
              vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticDefaultError' })
            '';
          }
          {
            plugin = nvim-dap-ui;
            type = "lua";
            config = ''
              require("dapui").setup()

              local dap, dapui = require("dap"), require("dapui")
              dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
              end
              dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
              end
              dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
              end
            '';
          }
          {
            plugin = comment-nvim;
            type = "lua";
            config = ''require("Comment").setup {}'';
          }
          {
            plugin = auto-save-nvim;
            type = "lua";
            config = ''require("auto-save").setup {}'';
          }
          {
            plugin = nvim-autopairs;
            type = "lua";
            config = ''require("nvim-autopairs").setup {}'';
          }
          {
            plugin = lsp-format-nvim;
            type = "lua";
            config = ''require("lsp-format").setup {}'';
          }
          cmp-path
          cmp-nvim-lsp-signature-help
          cmp_luasnip
          cmp-nvim-lsp
          luasnip
          vim-nix
          omnisharp-extended-lsp-nvim
          nvim-treesitter.withAllGrammars
          {
            plugin = sonokai;
            config = "colorscheme sonokai";
          }
        ];

        extraLuaConfig = ''
          ${builtins.readFile ./options.lua}
        '';
      };
    };
}











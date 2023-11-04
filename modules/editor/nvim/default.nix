{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.nvim;

  customPlugins = pkgs.callPackage ./customPlugins.nix { };

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
        ];

        plugins = with pkgs.vimPlugins; [
          {
            plugin = telescope-nvim;
            type = "lua";
            config = ''
              local builtin = require('telescope.builtin')
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
            plugin = lsp-format-nvim;
            type = "lua";
            config = ''require("lsp-format").setup {}'';
          }
          cmp_luasnip
          cmp-nvim-lsp
          luasnip
          vim-nix
          customPlugins.omnisharp-vim
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



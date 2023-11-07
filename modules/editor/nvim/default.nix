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
            config = builtins.readFile ./plugins/telescope.lua;
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
            config = builtins.readFile ./plugins/lualine.lua;
          }
          {
            plugin = nvim-dap;
            type = "lua";
            config = builtins.readFile ./plugins/dap.lua;
          }
          {
            plugin = nvim-dap-ui;
            type = "lua";
            config = builtins.readFile ./plugins/dap-ui.lua;
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
            config = ''
              let g:sonokai_style = 'andromeda'
              colorscheme sonokai
            '';
          }
        ];

        extraLuaConfig = builtins.readFile ./options.lua
      };
    };
}

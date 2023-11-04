{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.nvim;
in
{
  options.modules.nvim = { enable = lib.mkEnableOption "nvim"; };

  config = lib.mkIf cfg.enable {
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
		rnix-lsp
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
        	config = "${builtins.readFile ./plugins/lsp.lua}";
      	}
		{
        	plugin = nvim-cmp;
			type = "lua";
        	config = "${buildins.readFile ./plugins/cmp.lua}";
      	}
		cmp_luasnip
      	cmp-nvim-lsp
    	luasnip
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












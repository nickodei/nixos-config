{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.nvim;
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
          ripgrep
          fd
        ];

        plugins = with pkgs.vimPlugins; [
          {
            plugin = telescope-nvim;
            type = "lua";
            config = ''
              nmap("<leader>ff", ":Telescope find_files<cr>")
              nmap("<leader>fg", ":Telescope live_grep<cr>")
              nmap("<leader>fb", ":Telescope buffers<cr>")
              nmap("<leader>fh", ":Telescope help_tags<cr>")
            '';
          }
          nvim-treesitter.withAllGrammars
        ];
      };
    };
}












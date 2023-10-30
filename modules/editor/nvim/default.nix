{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.nvim;

  # plugins
  cmp-plugin = import ./cmp.nix;
  none-ls-plugin = import ./none-ls.nix;
  treesitter-plugin = import ./treesitter.nix;

  transformedColors = lib.mapAttrs (name: value: "#" + value) config.colorScheme.colors;
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options.modules.nvim = { enable = lib.mkEnableOption "nvim"; };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      options = {
        number = true; # Show line numbers
        relativenumber = true; # Show relative line numbers
        shiftwidth = 4; # Tab width should be 2
      };
      colorschemes = {
        base16 = {
          enable = true;
          customColorScheme = transformedColors;
        };
      };
      plugins = lib.mkMerge [{
        telescope = {
          enable = true;
          keymaps = {
            "<leader>pf" = {
              action = "find_files";
            };
          };
        };
        lualine.enable = true;
        nvim-autopairs.enable = true;
        fugitive = {
          enable = true;
        };
        harpoon = {
          enable = true;
          #  keymaps.addFile = "<leader>a";
        };
        lsp = {
          enable = true;
          keymaps = {
            silent = true;
            diagnostic = {
              "<leader>k" = "goto_prev";
              "<leader>j" = "goto_next";
            };
            lspBuf = {
              gd = "definition";
              K = "hover";
              ca = "code_action";
            };
          };
          servers = {
            cmake.enable = true;
            nixd.enable = true;
            clangd.enable = true;
          };
        };
        lsp-format = {
          enable = true;
        };
      }
      (treesitter-plugin.plugins)
      (cmp-plugin.plugins)
      (none-ls-plugin.plugins)];
      globals.mapleader = " ";
      keymaps = [
        {
          mode = "n";
          lua = true;
          key = "<leader>pv";
          action = "vim.cmd.Ex";
        }
      ];
    };
  };
}

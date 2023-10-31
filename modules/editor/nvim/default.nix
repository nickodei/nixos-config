{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.nvim;

  # plugins
  cmp-plugin = import ./cmp.nix;
  none-ls-plugin = import ./none-ls.nix;

  nvimThemes = {
    catppuccin-mocha = {
      colorScheme = {
        catppuccin = {
          enable = true;
          flavour = "mocha";
        };
      };
    };
  };

  transformedColors = lib.mapAttrs (name: value: "#" + value) config.colorScheme.colors;
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./treesitter.nix
    ./settings.nix
  ];

  options.modules.nvim = { enable = lib.mkEnableOption "nvim"; };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      colorschemes = nvimThemes.${config.colorScheme.slug}.colorScheme;
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

{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.nvim;

  # plugins
  cmp-plugin = import ./cmp.nix;
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
        cmp-nvim-lsp.enable = true;
        cmp-buffer.enable = true;
        cmp_luasnip.enable = true;
        cmp-path.enable = true;
        nvim-cmp = {
          enable = true;
          sources = [
            { name = "path"; }
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "crates"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = {
              action = "cmp.mapping.select_next_item()";
              modes = [ "i" "s" ];
            };
            "<S-Tab>" = {
              action = "cmp.mapping.select_prev_item()";
              modes = [ "i" "s" ];
            };
          };
          snippet.expand = "luasnip";
        };
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
        luasnip.enable = true;
      }
      (treesitter-plugin.plugins)
      (cmp-plugin.plugins)];
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

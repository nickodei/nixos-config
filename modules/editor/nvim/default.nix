{ inputs, pkgs, lib, config, ... }:

let
    cfg = config.modules.nvim;
in {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
    ];

    options.modules.nvim = { enable = lib.mkEnableOption "nvim"; };

    config = lib.mkIf cfg.enable {
        programs.nixvim = {
            enable = true;
            options = {
              number = true;         # Show line numbers
              relativenumber = true; # Show relative line numbers
              shiftwidth = 4;        # Tab width should be 2
            };
            colorschemes = {
              catppuccin = {
                enable = true;
                flavour = "mocha";
              };
            };
            plugins = {
              telescope = {
                enable = true;
                keymaps = {
                  "<leader>pf" = {
                    action = "find_files";
                  };
                };
              };
              #harpoon = {
              #  enable = true;
              #  keymaps.addFile = "<leader>a";
              #};
              treesitter = {
                enable = true;
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
                  nixd.enable = true;
                  clangd.enable = true;
                  cmake.enable = true;
                };
              };
            };
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
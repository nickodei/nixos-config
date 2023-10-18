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
              #coq-nvim = {
              #  enable = true;
              #  autoStart = true;
              #};
              #cmp-nvim-lsp.enable = true;
              nvim-cmp = {
                enable = true;
                sources = [
                  {name = "path";}
                  {name = "nvim_lsp";}
                  {name = "luasnip";}
                  {name = "crates";}
                  {name = "buffer";}
                ];
                mapping = {
                  "<C-d>" = "cmp.mapping.scroll_docs(-4)";
                  "<C-f>" = "cmp.mapping.scroll_docs(4)";
                  "<C-Space>" = "cmp.mapping.complete()";
                  "<C-e>" = "cmp.mapping.abort()";
                  "<CR>" = "cmp.mapping.confirm({ select = true })";
                  "<Tab>" = {
                    action = "cmp.mapping.select_next_item()";
                    modes = ["i" "s"];
                  };
                  "<S-Tab>" = {
                    action = "cmp.mapping.select_prev_item()";
                    modes = ["i" "s"];
                  };
                };
                snippet.expand = "luasnip";
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
                  cmake.enable = true;
                  nixd.enable = true;
                  clangd.enable = true;
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
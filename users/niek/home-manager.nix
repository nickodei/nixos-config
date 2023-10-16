
{ config, pkgs, inputs, ... }:

let 

in { 
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.hyprland.homeManagerModules.default
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  # Home - Default Settings
  home.username = "niek";
  home.homeDirectory = "/home/niek";

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.pointerCursor = {
    name = "Adwaita";
    size = 24;
    package = pkgs.gnome.adwaita-icon-theme;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  # Programs
  programs.git = {
    enable = true;
    userName  = "Niek Deibus";
    userEmail = "nickdeibus@outlook.de";
  };

  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      window_padding_width = 5;
    };
    theme = "Catppuccin-Mocha";
    font.name = "SauceCodePro NFM";
    shellIntegration.mode = "enabled";
    shellIntegration.enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAbbrs = {
      ll = "ls -l";
      test = "sudo nixos-rebuild test --flake /home/niek/nixos-config#work";
      update = "sudo nixos-rebuild switch --flake /home/niek/nixos-config#work";
    };
  };

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

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      #bbenoist.nix
      jnoortheen.nix-ide
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ];
    userSettings = {
      editor.fontFamily = "'SauceCodePro Nerd Font'";
      workbench.colorTheme = "Catppuccin Mocha";
      workbench.iconTheme = "Catppuccin Mocha";
      window.titleBarStyle = "custom";
      window.zoomLevel = 1;
      workbench.startupEditor = "none";
      nix.enableLanguageServer = true;
      nix.serverPath = "nixd";
    };
  };

  #programs.neovim = {
  #  enable = true;
  #  plugins = [
  #    pkgs.vimPlugins.telescope-nvim
  #    pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  #  ];
  #  extraConfig = ''
  #    set number relativenumber
  #  '';
  #};

  programs.firefox = {
    enable = true;
    profiles = {
      niek = {
        #extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        #  catppuccin-mocha-lavender
        #];
        bookmarks = [
          {
            name = "TUM";
            toolbar = true;
            bookmarks = [
              {
                name = "TUM Online";
                url = "https://campus.tum.de/tumonline/ee/ui/ca2/app/desktop/#/home?$ctx=design=ca;lang=de";
              }
              {
                name = "TUM Moodle";
                url = "https://www.moodle.tum.de/my/";
              }
              {
                name = "TUM Live";
                url = "https://live.rbg.tum.de/";
              }
            ];
          }
          {
            name = "NixOS";
            toolbar = true;
            bookmarks = [
              {
                name = "Configurations";
                url = "https://mynixos.com";
              }
            ];
          }
        ];
      };
    };


    #profiles."niek" = {
    #  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #    catppuccin catppuccin-mocha-lavender-
    #  ];
    #};
  };
}

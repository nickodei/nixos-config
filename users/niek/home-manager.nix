
{ config, lib, pkgs, inputs, ... }:

{ 
  imports = [
    ../../modules
    #inputs.nix-colors.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
  ];

  modules = {
    firefox.enable = true;
    kitty.enable = true;
    fish.enable = true;
    nvim.enable = true;
  };

  #colorScheme = inputs.nix-colors.colorScheme.catppuccin-mocha;

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

  #programs.firefox = {
  #  enable = true;
  #  profiles = {
  #    niek = {
  #      #extensions = with pkgs.nur.repos.rycee.firefox-addons; [
  #      #  catppuccin-mocha-lavender
  #      #];
  #      bookmarks = [
  #        {
  #          name = "TUM";
  #          toolbar = true;
  #          bookmarks = [
  #            {
  #              name = "TUM Online";
  #              url = "https://campus.tum.de/tumonline/ee/ui/ca2/app/desktop/#/home?$ctx=design=ca;lang=de";
  #            }
  #            {
  #              name = "TUM Moodle";
  #              url = "https://www.moodle.tum.de/my/";
  #            }
  #            {
  #              name = "TUM Live";
  #              url = "https://live.rbg.tum.de/";
  #            }
  #          ];
  #        }
  #        {
  #          name = "NixOS";
  #          toolbar = true;
  #          bookmarks = [
  #            {
  #              name = "Configurations";
  #              url = "https://mynixos.com";
  #            }
  #          ];
  #        }
  #      ];
  #    };
  #  };
#
#
  #  #profiles."niek" = {
  #  #  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
  #  #    catppuccin catppuccin-mocha-lavender-
  #  #  ];
  #  #};
  #};
}

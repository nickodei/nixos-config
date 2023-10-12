
{ config, pkgs, inputs, ... }:

{ 
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

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
    };
    theme = "Catppuccin-Mocha";
    font.name = "SauceCodePro NFM";
    shellIntegration.mode = "enabled";
    shellIntegration.enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      ll = "ls -l";
      test = "sudo nixos-rebuild test --flake /home/niek/nixos-config#work";
      update = "sudo nixos-rebuild switch --flake /home/niek/nixos-config#work";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ];
    userSettings = {
      editor.fontFamily = "'SauceCodePro Nerd Font'";
      workbench.colorTheme = "Catppuccin Mocha";
      workbench.iconTheme = "catppuccin-mocha";
      window.zoomLevel = 1;
    };
  };

  programs.firefox = {
    enable = true;
    #profiles."niek" = {
    #  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #    catppuccin
    #  ];
    #};
  };
}

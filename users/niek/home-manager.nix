
{ config, pkgs, inputs, ... }:

{ 
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../../modules/hyprland/home.nix
  ];

  # Home - Default Settings
  home.username = "niek";
  home.homeDirectory = "/home/niek";

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.pointerCursor = {
    name = "Adwaita";
    size = 32;
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
  };

  programs.vscode = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };
}


{ config, lib, pkgs, inputs, ... }:

{ 
  imports = [ ../../modules ];

  modules = {
    firefox.enable = true;
    kitty.enable = true;
    fish.enable = true;
    nvim.enable = true;
    git.enable = true;
    vscodium.enable = true;
    hyprland.enable = true;
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
}

{ inputs, pkgs, config, ... }:

{
  imports = [
      ./hyprland
      ./hyprpaper
      ./waybar
  ];
}
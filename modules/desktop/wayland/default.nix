{ inputs, pkgs, config, ... }:

{
  imports = [
    ./hyprland
    ./hyprpaper
    ./waybar
    ./mako
    ./wlogout.nix
  ];
}

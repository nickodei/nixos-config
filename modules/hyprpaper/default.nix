{ config, lib, pkgs, user, ... }:

{
    environment.systemPackages = with pkgs; [
        hyprpaper
    ];

    home-manager.users.${user} = {
        home.file = {
            ".config/hypr/hyprpaper.conf".text = ''
                preload = /etc/nixos/modules/wallpaper/background.jpg
                wallpaper = eDP-1,/etc/nixos/modules/wallpaper/background.jpg
            '';
        }
    };
}
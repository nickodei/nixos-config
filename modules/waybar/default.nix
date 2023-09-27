{ config, lib, pkgs, user, ... }:

{
    environment.systemPackages = with pkgs; [
        waybar
    ];

    home-manager.users.${user} = {
        programs.waybar = {
            enable = true;
        };
    };
}
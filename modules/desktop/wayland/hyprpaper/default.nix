{ inputs, pkgs, lib, config, ... }:

let
    cfg = config.modules.hyprpaper;
in {
    environment.systemPackages = with pkgs; [
        hyprpaper
    ];

    options.modules.hyprpaper = { 
        enable = lib.mkEnableOption "hyprpaper"; 
    };

    config = lib.mkIf cfg.enable {
        home.file = {
            ".config/hypr/hyprpaper.conf".text = ''
                preload = ~/nixos-config/modules/wallpaper/Moon-Commet.jpg
                wallpaper = eDP-1,~/nixos-config/modules/wallpaper/Moon-Commet.jpg
            '';
        };
    };
}
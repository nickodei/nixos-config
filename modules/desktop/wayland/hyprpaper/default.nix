{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.hyprpaper;
in {
  options.modules.hyprpaper = {
    enable = lib.mkEnableOption "hyprpaper";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.hyprpaper];
    home.file = {
      ".config/hypr/hyprpaper.conf".text = ''
        preload = ~/nixos-config/modules/wallpaper/mountain.png
        wallpaper = eDP-1,~/nixos-config/modules/wallpaper/mountain.png
      '';
    };
  };
}

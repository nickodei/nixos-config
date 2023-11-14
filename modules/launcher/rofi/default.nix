{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.rofi;
in {
  options.modules.rofi = {
    enable = lib.mkEnableOption "Rofi";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.rofi-bluetooth
      pkgs.rofi-screenshot
    ];

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = ./themes/launcher.rasi;
    };
  };
}

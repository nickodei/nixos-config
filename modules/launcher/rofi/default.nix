{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.rofi;
in
{
  options.modules.rofi = {
    enable = lib.mkEnableOption "Rofi";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {
        show-icons = true;
      };
      theme = ./themes/catppuccin-macchiato.rasi;
    };
  };
}

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
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {
        modi = "run,drun,window";
        icon-theme = "Oranchelo";
        show-icons = true;
        terminal = "kitty";
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        hide-scrollbar = true;
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = " 﩯  Window";
        display-Network = " 󰤨  Network";
        sidebar-mode = true;
      };
      theme = ./themes/catppuccin-macchiato.rasi;
    };

    xdg.configFile."rofi-menues/rofi-bluetooth.sh" = {
      executable = true;
      source = ./rofi-bluetooth.sh;
    };

    xdg.configFile."rofi-menues/rofi-network-manager.sh" = {
      executable = true;
      source = ./rofi-network-manager.sh;
    };

    xdg.configFile."rofi-menues/rofi-network-manager.conf" = {
      source = ./rofi-network-manager.conf;
    };
  };
}

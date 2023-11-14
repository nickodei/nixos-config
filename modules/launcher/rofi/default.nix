{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.rofi;

  rofi-bluetooth = pkgs.writeShellScriptBin (builtins.readFile ./rofi-bluetooth.sh);
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

    home.packages = [rofi-bluetooth];
  };
}

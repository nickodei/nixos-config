{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dunst;
in {
  options.modules.dunst = {
    enable = mkEnableOption "Dunst";
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings = {
        allow_markup = true;
        markup = true;
        format = "<span foreground='#5bb1b4'><b>%s</b></span>\n%b";
        sort = true;
        indicate_hidden = true;
        bounce_freq = 0;
        show_age_threshold = 60;
        word_wrap = true;
        ignore_newline = false;
        origin = "bottom-center";
        transparency = 0;
        idle_threshold = 120;
        monitor = 0;
        follow = "mouse";
        sticky_history = true;
        line_height = 0;
        separator_height = 2;
        padding = 12;
        horizontal_padding = 12;
        separator_color = "#3c4549";
        separator_width = 1;
        startup_notification = false;
        corner_radius = 15;
        frame_color = "#3c4549";
        frame_width = 1;
        width = 400;
        progress_bar_max_width = 400;
        progress_bar_min_width = 400;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_corner_radius = 5;
        scale = 1;
        min_icon_size = 64;
        max_icon_size = 64;
        alignment = "center";
        vertical_alignment = "center";
      };
    };
  };
}

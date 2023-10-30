{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.kitty;
in
{
  options.modules.kitty = {
    enable = lib.mkEnableOption "fish";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = with config.colorScheme.colors; {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        window_padding_width = 5;

       background = "#${base00}";
      foreground = "#${base05}";
      selection_background = "#${base05}";
      selection_foreground = "#${base00}";
      url_color = "#${base04}";
      cursor = "#${base05}";
      active_border_color = "#${base03}";
      inactive_border_color = "#${base01}";
      active_tab_background = "#${base00}";
      active_tab_foreground = "#${base05}";
      inactive_tab_background = "#${base01}";
      inactive_tab_foreground = "#${base04}";
      tab_bar_background = "#${base01}";

      # normal
      color0 = "#${base00}";
      color1 = "#${base08}";
      color2 = "#${base0B}";
      color3 = "#${base0A}";
      color4 = "#${base0D}";
      color5 = "#${base0E}";
      color6 = "#${base0C}";
      color7 = "#${base05}";

      # bright
      color8 = "#${base03}";
      color9 = "#${base08}";
      color10 = "#${base0B}";
      color11 = "#${base0A}";
      color12 = "#${base0D}";
      color13 = "#${base0E}";
      color14 = "#${base0C}";
      color15 = "#${base07}";

      # extended base16 colors
      color16 = "#${base09}";
      color17 = "#${base0F}";
      color18 = "#${base01}";
      color19 = "#${base02}";
      color20 = "#${base04}";
      color21 = "#${base06}";
      };
      theme = "Gruvbox Material Dark Medium";
      font.name = "SauceCodePro NFM";
      font.size = 14;
      shellIntegration.mode = "enabled";
      shellIntegration.enableFishIntegration = true;
    };
  };
}


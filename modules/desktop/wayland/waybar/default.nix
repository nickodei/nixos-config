{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.waybar;
in {
  options.modules.waybar = {
    enable = lib.mkEnableOption "waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      spacing = 6;
      settings = [
        {
          layer = "top";
          position = "top";
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "pulseaudio"
            "backlight"
            "battery"
            "network"
            "custom/seperator"
            "custom/restart"
            "custom/shutdown"
          ];
          network = {
            format = "{ifname}";
            format-wifi = "";
            format-ethernet = "󰈀";
            tooltip-format = "{ifname} via {gwaddr} 󰊗";
            tooltip-format-wifi = "{essid} ({signalStrength}%) ";
            tooltip-format-ethernet = "{ifname} ";
            tooltip-format-disconnected = "Disconnected";
          };
          battery = {
            states = {
              good = 95;
              warning = 30;
              critical = 20;
            };
            format = "{icon}";
            format-charging = "";
            format-plugged = "";
            format-alt = "{time} {icon}";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          backlight = {
            device = "intel_backlight";
            format = "{icon}";
            format-icons = ["󰃞" "󰃟" "󰃠"];
            tooltip = false;
          };
          pulseaudio = {
            scroll-step = 5;
            format = "{icon}";
            format-icons = ["󰕿" "󰖀" "󰕾"];
            format-muted = "    󰝟";
            on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
            on-click-right = "pavucontrol";
          };
          clock = {
            interval = 60;
            tooltip-format = "{calendar}";
            calendar = {
              format = {
                today = "<b><u>{}</u></b>";
              };
            };
            timezone = "Europe/Berlin";
          };
          cpu = {
            interval = 10;
            format = " {usage}%";
            max-length = 10;
          };
          memory = {
            interval = 30;
            format = " {used:0.1f}G";
            max-length = 10;
          };
          disk = {
            interval = 30;
            format = "󰋊 {percentage_used}%";
            path = "/";
          };
          "hyprland/workspaces" = {
            active-only = false;
            all-outputs = true;
            format = "{icon}";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "8" = "";
              active = "";
              default = "";
            };
          };
          "custom/shutdown" = {
            format = "";
          };
          "custom/restart" = {
            format = "";
          };
          "custom/seperator" = {
            format = "|";
          };
        }
      ];
      style = ''
         * {
             font-family: "SauceCodePro NFM";
             font-size: 16px;
         	color: #b0b4bc;
         }

        window#waybar {
            background: none;
        }
      '';
    };
  };
}

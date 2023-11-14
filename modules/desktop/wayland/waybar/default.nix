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
      settings = [
        {
          layer = "top";
          position = "top";
          spacing = 12;
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            #"memory"
            #"cpu"
            "custom/seperator"
            "pulseaudio"
            "backlight"
            "battery"
            "bluetooth"
            "network"
            "custom/seperator"
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
          bluetooth = {
            format-on = "";
            format-off = "";
            format-disabled = "󰂲";
            format-connected = "󰂱";
          };
          battery = {
            states = {
              good = 70;
              warning = 20;
              critical = 5;
            };
            format = "{icon}";
            format-charging = "{icon}";
            format-alt = "{time} {icon}";
            format-icons = ["" "" "" "" ""];
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
            format-muted = "󰝟";
            on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
            on-click-right = "pavucontrol";
          };
          clock = {
            interval = 60;
            format = "{:%a %Od %b | %H:%M}";
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
            format = ''{usage}%,'';
            max-length = 10;
          };
          memory = {
            interval = 30;
            format = "{used:0.1f}G,";
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
                          #workspaces {
                          	margin-left: 8px;
                          }
                          #workspaces button {
                          	padding: 0 2px;
                          }

                          .modules-left {
                          	padding-top: 6px;
                          	padding-left: 6px;
                          }

                          .modules-center {
                          	padding-top: 6px;
                          }

                          .modules-right {
                          	padding-top: 6px;
                          	padding-right: 12px;
                          }

                    #network,
        #bluetooth,
              #battery,
              #backlight,
              #pulseaudio {
                    	font-size: 20px;
                    }

           #cpu span {
           	margin-left: -5px;
           }
      '';
    };
  };
}

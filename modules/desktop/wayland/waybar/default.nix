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
          spacing = 0;
          height = 38;
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "battery"
            "backlight"
            "pulseaudio"
            "pulseaudio#mic"
            "tray"
            "custom/clock-icon"
          ];
          tray = {
            spacing = 10;
          };
          battery = {
            states = {
              good = 95;
              warning = 30;
              critical = 20;
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          "custom/window-name" = {
            format = "<b>{}</b>";
            interval = 1;
            exec = "hyprctl activewindow | grep class | awk '{print $2}'";
          };
          backlight = {
            device = "intel_backlight";
            format = "{percent}% {icon}";
            format-icons = ["󰃞" "󰃟" "󰃠"];
            tooltip = false;
          };
          pulseaudio = {
            scroll-step = 5;
            format = "{volume}% {icon}";
            format-icons = ["󰕿" "󰖀" "󰕾"];
            format-muted = "    󰝟";
            on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
            on-click-right = "pavucontrol";
          };
          "pulseaudio#mic" = {
            format = "{format_source}";
            format-source = "";
            format-source-muted = "";
            on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            tooltip = false;
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
          "custom/separator" = {
            format = " ";
          };
          "custom/window-icon" = {};
          "custom/wrap-left" = {
            format = "<b>[</b>";
          };
          "custom/wrap-right" = {
            format = "<b>]</b>";
          };
          "hyprland/workspaces" = {
            all-outputs = true;
            format = "{icon}";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              active = "";
              default = "";
            };
          };
          temperature = {
            thermal-zone = 0;
            critical-threshold = 80;
            format-critical = " {temperatureC}°C";
            format = " {temperatureC}°C";
          };
          "custom/nixos" = {
            format = "";
          };
          "custom/clock-icon" = {
            format = "";
          };
        }
      ];
      style = ''
                  * {
                       padding: 0px;
                       margin: 0px;
                       font-family: "SauceCodePro NFM";
                       font-size: 14px;
                   }

                   window#waybar {
        background: none;
                   }

                   .modules-left {
                       border-radius: 8px;
                       padding-right: 15px;
                       padding-left: 8px;
                   }

                   .modules-center {
                       border-radius: 8px;
                       padding-right: 10px;
                       padding-left: 10px;
                   }

                   .modules-right {
                       border-radius: 8px;
                       padding-right: 15px;
                       padding-left: 15px;
                   }

                   #custom-nixos {
                       font-size: 24px;
         padding-left: 4px;
         padding-right: 4px;
                       color: #00bfff; /* deepskyblue */
                   }

                   #cpu,
                   #memory,
                   #disk,
                   #temperature {
                       background: #363a4f;
                       font-size: 14px;
                       padding: 5px 7px 5px 7px;
                       margin-top: 5px;
                       margin-bottom: 5px;
                   }

                   #cpu {
                       color: #eed49f;
                       border-radius: 5px 0px 0px 5px;
                   }

                   #disk {
                       color: #eed49f;
                   }

                   #memory {
                       color: #a6da95;
                   }

                   #temperature {
                       color: #8aadf4;
                       border-radius: 0px 5px 5px 0px;
                   }

                   #custom-window-name {
                       margin-right: 10px;
                       color: #cad3f5;
                   }

                   #battery {
                       font-size: 14px;
                       color: #a6da95;
                       padding-right: 12px;
                   }

                   #pulseaudio,
                   #backlight {
                       font-size: 14px;
                       background: #363a4f;
                       padding: 5px 7px 5px 7px;
                       margin-top: 5px;
                       margin-bottom: 5px;
                   }

                   #backlight {
                       color: #eed49f;
                       border-radius: 5px 0px 0px 5px;
                   }

                   #tray {
                       padding: 0px 10px 0px 10px;
                   }

                   #pulseaudio {
                       color: #91d7e3;
                   }

                   #pulseaudio.mic {
                       border-radius: 0px 5px 5px 0px;
                   }

                   #custom-right-arr {
                       color: #8aadf4;
                   }

                   #bluetooth {
                       color: #8aadf4;
                       margin-right: 10px;
                   }

                   #network {
                       color: #c6a0f6;
                       margin-right: 5px;
                   }

                   #custom-dot {
                       color: #6e738d;
                       padding-left: 10px;
                       padding-right: 10px;
                   }

                   #custom-dot-alt {
                       color: #a5adcb;
                       padding-left: 10px;
                       padding-right: 10px;
                   }

                   #custom-clock-icon {
                       color: #cad3f5;
                       margin-top: 3px;
                       margin-bottom: 3px;
                   }

                   #clock {
          	    font-size: 16px;
                       padding-left: 10px;
                       color: #cad3f5;
                   }
      '';
    };
    home.file = {
      ".config/waybar/microphone.sh" = {
        text = ''
          if [[ ! $(wpctl status | rg "capture") ]]; then
              echo ""
              exit 0
          fi

          text=""
          [[ $(wpctl get-volume @DEFAULT_SOURCE@ | rg MUTED) ]] && text=""

          echo -e "$text\n$(wpctl get-volume @DEFAULT_SOURCE@)"
        '';
        executable = true;
      };
    };
  };
}

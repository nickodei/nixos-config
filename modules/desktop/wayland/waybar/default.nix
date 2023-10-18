{ inputs, pkgs, lib, config, ... }:

let
    cfg = config.modules.waybar;
in {
    options.modules.waybar = { 
        enable = lib.mkEnableOption "waybar"; 
    };

    config = lib.mkIf cfg.enable {
        programs.waybar = {
            enable = true;
            settings = [{
                layer = "top";
                position = "top";
                spacing = 1;
                height = 32;
                modules-left = [
                    "custom/nixos"
                    "custom/separator"
                    "cpu"
                    "memory"
                    "disk"
                    "temperature"
                    "custom/separator"
                    "custom/window-name"
                ];
                modules-center = [
                    "hyprland/workspaces"
                ];
                modules-right = [
                    "battery"
                    "backlight"                   
                    "pulseaudio"
                    "pulseaudio#mic"
                    "bluetooth"
                    "network"
                    "custom/clock-icon"
                    "clock"
                ];
                bluetooth = {
                    format = "󰂲";
                    format-connected = "󰂯";
                    tooltip-format = "{controller_alias}\t{controller_address}\n{num_connections} connected";
                    tooltip-format-connected = "{controller_alias}\t{controller_address}\n{num_connections} connected\n\n{device_enumerate}";
                    tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
                    tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
                    on-click = "kitty -e bluetoothctl";
                };
                battery = {
                    bat = "BAT0";
                    interval = 60;
                    states = {
                        warning = 30;
                        critical = 15;
                    };
                    format = "{capacity}% {icon}";
                    format-icons = ["" "" "" "" ""];
                    max-length = 25;
                };
                "custom/window-name" = {
                    format = "<b>{}</b>";
                    interval = 1;
                    exec = "hyprctl activewindow | grep class | awk '{print $2}'";
                };
                network = {
                    format-wifi = "{icon} ";
                    format-icons = [ "󰤯" "󰤟" "󰤢" "󰤢" "󰤨" ];
                    format-ethernet = "{ipaddr}/{cidr}";
                    format-disconnected = "󰤮 ";
                    tooltip-format-wifi = "{essid}; Strength: {signalStrength}%";
                    tooltip-format-ethernet = "";
                    max-length = 50;
                    on-click = "kitty";
                };
                backlight = {
                    device = "intel_backlight";
                    format = "{percent}% {icon}";
                    format-icons = [ "󰃚" "󰃛" "󰃜" "󰃝" "󰃞" "󰃟" "󰃠" ];
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
                    timezone = "Europe/Rome";
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
                        urgent = "";
                        active = "";
                        default = "";
                    };
                };
                temperature = {
                    thermal-zone = 0;
                    critical-threshold = 80;
                    format-critical = " {temperatureC}°C";
                    format =  " {temperatureC}°C";
                };
                "custom/nixos" = {
                    format = "";
                };
                "custom/clock-icon" = {
                    format = "";
                };
            }];
            style = ''
                * {
                    padding: 0;
                    margin: 0;
                    font-family: "SauceCodePro NFM";
                    font-size: 16px;
                }

                window#waybar {
                    background: rgba(30, 32, 48, 0.8);
                }

                .modules-left {            
                    border-radius: 8px;
                    padding-right: 15px;
                    padding-left: 15px;
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
                    color: #00bfff; /* deepskyblue */
                    padding-right: 8px;
                }

                #cpu,
                #memory,
                #disk,
                #temperature {
                    font-size: 14px;
                    background: #363a4f;
                    padding: 4px;
                    margin-top: 5px;
                    margin-bottom: 5px;
                }

                #cpu {
                    color: #eed49f;
                    padding: 0px 15px 0px 12px;
                    border-radius: 5px 0px 0px 5px;
                }

                #disk {
                    color: #eed49f;
                    padding: 0px 15px 0px 0px;
                    margin-left: -1px;
                }

                #memory {
                    color: #a6da95;
                    padding: 0px 15px 0px 0px;
                    margin-left: -1px;
                }

                #temperature {
                    color: #8aadf4;
                    padding: 0px 15px 0px 0px;
                    border-radius: 0px 5px 5px 0px;
                    margin-left: -1px;
                }

                #custom-window-name {
                    margin-right: 10px;
                    color: #cad3f5;
                }

                #workspaces button:nth-child(1) label {
                    color: #8aadf4;
                    margin: 0px 8px;
                }

                #workspaces button:nth-child(2) label {
                    color: #ed8796;
                    margin: 0px 8px;
                }

                #workspaces button:nth-child(3) label {
                    color: #a6da95;
                    margin: 0px 8px;
                }

                #workspaces button:nth-child(4) label {
                    color: #c6a0f6;
                    margin: 0px 8px;
                }

                #workspaces button:nth-child(5) label {
                    color: #f4dbd6;
                    margin: 0px 8px;
                }

                #workspaces button:nth-child(6) label {
                    color: #f5a97f;
                    margin: 0px 8px;
                }

                #battery {
                    color: #a6da95;
                    margin: 0px 10px 0px 0px;
                }

                #pulseaudio,
                #backlight {
                    font-size: 14px;
                    background: #363a4f;
                    padding: 4px;
                    margin-top: 5px;
                    margin-bottom: 5px;
                }

                #backlight {
                    color: #eed49f;
                    padding: 0px 15px 0px 10px;
                    border-radius: 5px 0px 0px 5px;
                    margin-left: -1px;
                }

                #pulseaudio {
                    color: #91d7e3;
                    padding: 0px 15px 0px 0px;
                    margin-left: -1px;
                }

                #pulseaudio.mic {
                    border-radius: 0px 5px 5px 0px;
                    margin-right: 5px;
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
                    margin-top: 5px;
                    margin-bottom: 5px;
                }

                #clock {
                    padding-left: 10px;
                    color: #cad3f5;
                }
            '';
        };
        home.file = {
            ".config/waybar/microphone.sh" =  {
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
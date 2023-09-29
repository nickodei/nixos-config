{ config, lib, pkgs, user, ... }:

{
    environment.systemPackages = with pkgs; [
        waybar
    ];

    home-manager.users.${user} = {
        programs.waybar = {
            enable = true;
            settings = [{
                layer = "top";
                position = "top";
                spacing = 1;
                height = 32;
                modules-center = [
                    "hyprland/workspaces"
                ];
                modules-right = [
                    "cpu"
                    "memory"
                    "clock"
                ];
                modules-left = [
                    "network"
                    "bluetooth"
                    "pulseaudio"
                    "pulseaudio#mic"
                    "backlight"
                    "battery"
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
                    format = "{usage}% ";
                    max-length = 10;
                };
                memory = {
                    interval = 30;
                    format = "{used:0.1f}G ";
                    max-length = 10;
                };
            }];
            style = ''
                * {
                    font-family: "SauceCodePro NFM";
                    font-weight: 600;
                    font-size: 16px;
                }

                window#waybar {
                    background: transparent;
                }


		.modules-left, 
		.modules-center, 
		.modules-right {
		    background: #282828;
		    margin: 8px;
		    border-radius: 8px;
		    border: solid 2px #928374;
		    padding-left: 4px;
		    padding-right: 4px;
		}

                label {
                    padding: 0 8px;
                    color: #FBF9C7;
                }

                button {
                    margin: 4px 0;
                    border-radius: 4px;
                }

                tooltip {
                    background: #282828;
                    border: solid 1px #928374;
                    border-radius: 4px;
                }

                #idle_inhibitor {
                    margin: 4px 30px 4px 15px;
                    padding-right: 15px;
                    border-radius: 4px;
                }

                #idle_inhibitor.activated {
                    color: #3C3836;
                    background: #FABD2F;
                }

                #workspaces button {
                    padding: 0;
                }
                #workspaces button.active {
                    background: #689d6a;
                }

                #custom-bat.critical, #custom-microphone {
                    color: #FB4934;
                }

                /* Layout */
                #custom-bat {
                    margin: 0 20px 0 30px;
                }
                #pulseaudio {
                    margin-left: 30px;
                }
                #network {
                    margin-left: 30px;
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

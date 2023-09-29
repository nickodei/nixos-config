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
                modules-left = [
                    "idle_inhibitor"
                    "wlr/workspaces"
                ];
                modules-center = [
                    "clock"
                ];
                modules-right = [
                    "custom/microphone"
                    "network"
                    "bluetooth"
                    "pulseaudio"
                    "backlight"
                    "custom/bat"
                ];
                "custom/bat" = {
                    #exec = "~/.config/waybar/bat.sh";
                    interval = 5;
                };
                "custom/microphone" = {
                    #exec = "~/.config/waybar/microphone.sh";
                    on-click = "pavucontrol";
                    format = "{}";
                    interval = 2;
                };
                bluetooth = {
                    format = "󰂲";
                    format-connected = "";
                    tooltip-format = "{controller_alias}\t{controller_address}\n{num_connections} connected";
                    tooltip-format-connected = "{controller_alias}\t{controller_address}\n{num_connections} connected\n\n{device_enumerate}";
                    tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
                    tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
                    on-click = "kitty -e bluetoothctl";
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
                idle_inhibitor = {
                    format = "{icon}";
                    format-icons = {
                        activated = "";
                        deactivated = "鈴";
                    };
                };
            }];
            style = ''
                * {
                    font-family: "SauceCodePro Nerd Font";
                    font-weight: 600;
                    font-size: 16px;
                }

                window {
                    background: #282828;
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
    };
}
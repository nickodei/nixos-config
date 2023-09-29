{ config; lib; pkgs; user; ... }:

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
                    "image"
                    "clock"
                ];
                modules-right = [
                    "custom/pacman"
                    "custom/microphone"
                    "network"
                    "bluetooth"
                    "pulseaudio"
                    "backlight"
                    "custom/bat"
                ];
                "custom/bat" = {
                    exec = "~/.config/waybar/bat.sh";
                    interval = 5;
                };
                "custom/microphone" = {
                    exec = "~/.config/waybar/microphone.sh";
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
                "custom/pacman" = {
                    interval = 3600;
                    exec = "~/.config/waybar/pacman.sh";
                    on-click = "kitty -e paru -Syu && pkill -SIGRTMIN+8 waybar";
                    signal = 8;
                    tooltip = false;
                };
                image = {
                    interval = 600;
                    exec-if = "ping wttr.in -c 1";
                    exec = "~/.config/waybar/weather.sh";
                    on-click = "$BROWSER https://www.3bmeteo.com/meteo/luzzi &";
                };
            }];
        };
    };
}
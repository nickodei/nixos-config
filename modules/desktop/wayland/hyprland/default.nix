{ inputs, pkgs, lib, config, host, ... }:

let
    cfg = config.modules.hyprland;
in {
    imports = [
        inputs.hyprland.homeManagerModules.default
    ];

    options.modules.hyprland = { 
        enable = lib.mkEnableOption "hyprland"; 
        hidpi = lib.mkEnableOption "Hdpi Display";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [
            pkgs.dconf
	    pkgs.qt6.qtwayland
	    pkgs.libsForQt5.qt5.qtwayland
        ];

        home.sessionVariables = {
            #GTK_THEME = "Catppuccin-Mocha-Standard-Lavender-dark:dark";
            GDK_SCALE = lib.mkIf (cfg.hidpi) 2;
            XCURSOR_SIZE = lib.mkIf (cfg.hidpi) 32;
        };

        wayland.windowManager.hyprland = {
            enable = true;
            systemdIntegration = true;
            enableNvidiaPatches = if host == "dell-xps-17" then true else false;
            xwayland.enable = true;
            extraConfig = ''
            # Monitors
            ${builtins.concatStringsSep "\n" (map(m:
                let
                    resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
                    position = "${toString m.x}x${toString m.y}";
                in
                    "${m.name},${if m.enabled then "${resolution},${position},${toString m.scale}" else "disable"}"
            )(config.monitors))}

            # Startup Applications
            exec-once = waybar & hyprpaper & mako
            
            ${if cfg.hidpi then ''
                # Fix HiDPI XWayland windows
                exec-once=xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2
            '' else ""}

            # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
            input {
                kb_layout = de
                follow_mouse = 1
                touchpad {
                    natural_scroll = true
                }
                sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
            }

            general {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more

                gaps_in = 4
                gaps_out = 8
                border_size = 2
                col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
                col.inactive_border = rgba(595959aa)

                layout = dwindle
            }

            decoration {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more

                rounding = 10

                blur {
                    enabled = true
                    size = 3
                    passes = 1
                }

                drop_shadow = true
                shadow_range = 4
                shadow_render_power = 3
                col.shadow = rgba(1a1a1aee)
            }

            animations {
                enabled = true

                # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

                bezier = myBezier, 0.05, 0.9, 0.1, 1.05

                animation = windows, 1, 7, myBezier
                animation = windowsOut, 1, 7, default, popin 80%
                animation = border, 1, 10, default
                animation = borderangle, 1, 8, default
                animation = fade, 1, 7, default
                animation = workspaces, 1, 6, default
            }

            dwindle {
                # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
                pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = true # you probably want this
            }

            master {
                # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
                new_is_master = true
            }

            gestures {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more
                workspace_swipe = true
            }

            # Example per-device config
            # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
            device:epic-mouse-v1 {
                sensitivity = -0.5
            }

            # Example windowrule v1
            # windowrule = float, ^(kitty)$
            # Example windowrule v2
            # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
            # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


            # See https://wiki.hyprland.org/Configuring/Keywords/ for more
            $mainMod = SUPER

            # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
            bind = $mainMod, K, exec, kitty
            bind = $mainMod, Q, killactive,
            bind = $mainMod, C, exec, codium
            bind = $mainMod, O, exec, obsidian
            bind = $mainMod, S, exec, spotify
            bind = $mainMod, L, exec, swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2
	    bind = $mainMod, M, exit,
            bind = $mainMod, E, exec, thunar
            bind = $mainMod, V, togglefloating,
            bind = $mainMod, R, exec, wofi --show drun
            bind = $mainMod, P, pseudo, # dwindle
            bind = $mainMod, J, togglesplit, # dwindle
            bind = $mainMod, B, exec, firefox

	    # Fn-Keys
	    binde  = , XF86AudioRaiseVolume, exec, pamixer -i 5
	    binde  = , XF86AudioLowerVolume, exec, pamixer -d 5
	    bindle = , XF86AudioMute, exec, pamixer --toggle-mute
	    binde  = , xf86MonBrightnessUp, exec, brightnessctl set +10%
	    binde  = , xf86MonBrightnessDown, exec, brightnessctl set 10%-

            # Move focus with mainMod + arrow keys
            bind = $mainMod, left, movefocus, l
            bind = $mainMod, right, movefocus, r
            bind = $mainMod, up, movefocus, u
            bind = $mainMod, down, movefocus, d

            # Switch workspaces with mainMod + [0-9]
            bind = $mainMod, 1, workspace, 1
            bind = $mainMod, 2, workspace, 2
            bind = $mainMod, 3, workspace, 3
            bind = $mainMod, 4, workspace, 4
            bind = $mainMod, 5, workspace, 5
            bind = $mainMod, 6, workspace, 6
            bind = $mainMod, 7, workspace, 7
            bind = $mainMod, 8, workspace, 8
            bind = $mainMod, 9, workspace, 9
            bind = $mainMod, 0, workspace, 10

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            bind = $mainMod SHIFT, 1, movetoworkspace, 1
            bind = $mainMod SHIFT, 2, movetoworkspace, 2
            bind = $mainMod SHIFT, 3, movetoworkspace, 3
            bind = $mainMod SHIFT, 4, movetoworkspace, 4
            bind = $mainMod SHIFT, 5, movetoworkspace, 5
            bind = $mainMod SHIFT, 6, movetoworkspace, 6
            bind = $mainMod SHIFT, 7, movetoworkspace, 7
            bind = $mainMod SHIFT, 8, movetoworkspace, 8
            bind = $mainMod SHIFT, 9, movetoworkspace, 9
            bind = $mainMod SHIFT, 0, movetoworkspace, 10

            # Scroll through existing workspaces with mainMod + scroll
            bind = $mainMod, mouse_down, workspace, e+1
            bind = $mainMod, mouse_up, workspace, e-1

            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod, mouse:273, resizewindow
            '';
        };

        home = {
            pointerCursor = {
                size = 24;
                name = "Adwaita";
                gtk.enable = true;
                package = pkgs.gnome.adwaita-icon-theme;
            };
        };
        gtk = {
            enable = true;
            theme = {
                name = "Catppuccin-Mocha-Compact-Lavender-Dark";
                package = pkgs.catppuccin-gtk.override {
                    accents = [ "lavender" ];
                    tweaks = [ "rimless" "normal" ];
                    variant = "mocha";
                    size = "compact";
                };
            };
            iconTheme = {
                package = pkgs.gnome.adwaita-icon-theme;
                name = "Adwaita";
            };
        };
    };
}

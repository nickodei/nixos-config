{
  inputs,
  pkgs,
  lib,
  config,
  host,
  ...
}:
with lib; let
  cfg = config.modules.wayland.hyprland;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  options.modules.wayland.hyprland = {
    enable = mkEnableOption "hyprland";
    nvidia = mkEnableOption "Nvidia support";
    hidpi = mkEnableOption "Hdpi Display";
    monitors = mkOption {
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "DP-1";
          };
          width = mkOption {
            type = types.int;
            example = 1920;
          };
          height = mkOption {
            type = types.int;
            example = 1080;
          };
          refreshRate = mkOption {
            type = types.int;
            default = 60;
          };
          x = mkOption {
            type = types.int;
            default = 0;
          };
          y = mkOption {
            type = types.int;
            default = 0;
          };
          scale = mkOption {
            type = types.number;
            default = 1;
          };
          enabled = mkOption {
            type = types.bool;
            default = true;
          };
        };
      });
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      dconf
      qt6.qtwayland
      libsForQt5.qt5.qtwayland
    ];

    home.sessionVariables =
      {
        GDK_SCALE = lib.mkIf (cfg.hidpi) 2;
        XCURSOR_SIZE = lib.mkIf (cfg.hidpi) 32;

        # Toolkit variables
        GDK_BACKEND = "wayland,x11";
        QT_QPA_PLATFORM = "wayland;xcb";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";

        # XDG specific
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
      }
      // (optionalAttrs (cfg.nvidia) {
        # Necessary to correctly enable va-api (video codec hardware
        # acceleration). If this isn't set, the libvdpau backend will be
        # picked, and that one doesn't work with most things, including
        # Firefox.
        LIBVA_DRIVER_NAME = "nvidia";
        # Required to run the correct GBM backend for nvidia GPUs on wayland
        GBM_BACKEND = "nvidia-drm";
        # Apparently, without this nouveau may attempt to be used instead
        # (despite it being blacklisted)
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        # Hardware cursors are currently broken on nvidia
        WLR_NO_HARDWARE_CURSORS = "1";

        # Required to use va-api it in Firefox. See
        # https://github.com/elFarto/nvidia-vaapi-driver/issues/96
        MOZ_DISABLE_RDD_SANDBOX = "1";
        # It appears that the normal rendering mode is broken on recent
        # nvidia drivers:
        # https://github.com/elFarto/nvidia-vaapi-driver/issues/213#issuecomment-1585584038
        NVD_BACKEND = "direct";
        # Required for firefox 98+, see:
        # https://github.com/elFarto/nvidia-vaapi-driver#firefox
        EGL_PLATFORM = "wayland";
      });

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemdIntegration = true;
      enableNvidiaPatches = cfg.nvidia;
      package = pkgs.inputs.hyprland.hyprland;
      plugins = [
        inputs.hyprgrass.packages.${pkgs.system}.default
      ];
      settings = {
        general = {
          gaps_in = 4;
          gaps_out = 8;
          border_size = 2;
          "col.active_border" = "rgba(595cffee) rgba(c6f8ffee) -45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
        };
        input = {
          kb_layout = "de";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = true;
          };
          sensitivity = 0;
        };
        plugin = {
          touch_gestures = {
            sensitivity = 4.0;
            workspace_swipe_fingers = 3;
          };
        };
        decoration = {
          rounding = 5;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };
        animations = {
          enabled = true;
          bezier = ["myBezier, 0.05, 0.9, 0.1, 1.05"];

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };
        dwindle = {
          pseudotile = true; # master switch for pseudotiling.
          preserve_split = true; # you probably want this
        };
        master = {
          new_is_master = true;
        };
        gestures = {
          workspace_swipe = true;
        };
        exec-once =
          [
            "waybar"
            "hyprpaper"
            "dunst"
          ]
          ++ (lib.optionals cfg.hidpi [
            ''
              # Fix HiDPI XWayland windows
              xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2
            ''
          ]);
        bind = [
          # Programs
          "SUPER, K, exec, kitty"
          "SUPER, Q, killactive,"
          "SUPER, C, exec, code"
          "SUPER, O, exec, obsidian"
          "SUPER, S, exec, spotify"
          "SUPER, L, exec, swaylock"
          "SUPER, M, exit,"
          "SUPER, E, exec, thunar"
          "SUPER, V, togglefloating,"
          "SUPER, R, exec, wofi --show drun"
          "SUPER, P, pseudo," # dwindle
          "SUPER, J, togglesplit," # dwindle
          "SUPER, B, exec, firefox"
          "SUPER, R, exec, rofi -show drun"

          # Move focus with mainMod + arrow keys
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          # Switch workspaces with mainMod + [0-9]
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"

          # Scroll through existing workspaces with mainMod + scroll
          "SUPER, mouse_down, workspace, e+1"
          "SUPER, mouse_up, workspace, e-1"
        ];
        binde = [
          ", XF86AudioRaiseVolume, exec, pamixer -i 5"
          ", XF86AudioLowerVolume, exec, pamixer -d 5"
          ", xf86MonBrightnessUp, exec, brightnessctl set +10%"
          ", xf86MonBrightnessDown, exec, brightnessctl set 10%-"
        ];
        bindle = [
          ", XF86AudioMute, exec, pamixer --toggle-mute"
        ];
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
        monitor = map (
          m: let
            resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            position = "${toString m.x}x${toString m.y}";
          in "${m.name},${
            if m.enabled
            then "${resolution},${position},${toString m.scale}"
            else "disable"
          }"
        ) (cfg.monitors);
      };
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
          accents = ["lavender"];
          tweaks = ["rimless" "normal"];
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

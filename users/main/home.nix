{ config, lib, pkgs, inputs, host, user, ... }:

let
  available-monitors = import ./../../modules/desktop/wayland/monitors.nix;
  monitors = (
    if (host == "dell-xps-17") then [ available-monitors.dell-xps-17 ]
    else if (host == "surface-pro") then [ available-monitors.surface-pro-8 ]
    else [ ]
  ) ++ [ available-monitors.view-sonic-32 ];
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ../../modules
    ../../modules/programs/imports.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha; #edge-dark; #catppuccin-macchiato;

  modules = {
    firefox.enable = true;
    kitty.enable = true;
    fish.enable = true;
    nvim.enable = true;
    git.enable = true;
    vscodium.enable = true;
    spotify.enable = true;
    obsidian.enable = true;
    blueman-applet.enable = true;

    wayland = {
      hyprland = {
        enable = true;
        hidpi = true;
        monitors = monitors;
      };
      wlogout.enable = true;
    };

    hyprpaper.enable = true;
    waybar.enable = true;
    rofi.enable = true;

    # Development
    direnv.enable = true;
  };

  # Home - Default Settings
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}

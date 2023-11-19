{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  available-monitors = import ./../../modules/desktop/wayland/monitors.nix;
  # monitors =
  #   (
  #     if (host == "dell-xps-17")
  #     then [available-monitors.dell-xps-17]
  #     else if (host == "surface-pro")
  #     then [available-monitors.surface-pro-8]
  #     else []
  #   )
  #   ++ [available-monitors.view-sonic-32];
in {
  imports = [
    ../../modules
    ../../modules/programs/imports.nix
    #inputs.nix-colors.homeManagerModules.default
  ];

  #colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.packages = [
    (import ./../../modules/util/scripts/set-volume/set-volume.nix {inherit pkgs;})
  ];

  modules = {
    firefox.enable = true;
    chromium.enable = true;

    kitty.enable = true;
    fish.enable = true;
    nvim.enable = true;
    git.enable = true;
    vscodium.enable = true;
    dunst.enable = true;
    rofi.enable = true;

    spotify.enable = true;
    obsidian.enable = true;
    blueman-applet.enable = true;

    wayland = {
      hyprland = {
        enable = true;
        hidpi = true;
        nvidia = false; #osConfig.modules.hardware.nvidia.enable;
        monitors = [];
      };
      wlogout.enable = true;
    };

    hyprpaper.enable = true;
    waybar.enable = true;

    # Development
    direnv.enable = true;
  };

  # Home - Default Settings
  home.username = "main";
  home.homeDirectory = "/home/main";

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}

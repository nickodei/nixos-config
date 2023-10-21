
{ config, lib, pkgs, inputs, host, user, ... }:

{ 
  imports = [ 
    ../../modules
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  modules = {
    firefox.enable = true;
    kitty.enable = true;
    fish.enable = true;
    nvim.enable = true;
    git.enable = true;
    vscodium.enable = true;

    hyprland = {
      enable = true;
      hidpi = true;
    };
    
    hyprpaper.enable = true;
    waybar.enable = true;

    # Development
    direnv.enable = true;
  };

  monitors = [
    {
      name = "eDP-1";
      width = 3840;
      height = 2400;
      refreshRate = 60;
      x = 0;
      y = 0;
      scale = 2;
      enabled = true;
    }
  ];

  # Home - Default Settings
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}

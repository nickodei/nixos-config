{ config, lib, pkgs, ... }:

{
  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "18.09";

  #---------------------------------------------------------------------
  # Desktop
  #---------------------------------------------------------------------
  imports = [ ../../modules/hyprland/waybar/home.nix ];

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------
  programs.git = {
    enable = true;
    userName = "Niek Deibus";
    userEmail = "nickdeibus@outlook.de";
  };
}
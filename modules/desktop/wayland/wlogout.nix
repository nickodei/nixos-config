{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.wayland.wlogout;
in
{
  options.modules.wayland.wlogout = {
    enable = mkEnableOption "hyprpaper";
  };

  config = mkIf cfg.enable {
    programs.wlogout = {
      enable = true;
    };
  };
}

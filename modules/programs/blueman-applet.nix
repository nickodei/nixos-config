{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.blueman-applet;
in
{
  options.modules.blueman-applet = {
    enable = mkEnableOption "Blueman applet";
  };

  config = mkIf cfg.enable {
    services.blueman-applet.enable = true;
  };
}

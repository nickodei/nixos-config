{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.hardware.bluetooth;
in
{
  options.modules.hardware.bluetooth = {
    enable = mkEnableOption "Bluetooth";
  };

  config = mkIf cfg.enable
    {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.settings = {
        General = {
          AutoConnect = true;
          Enable = "Source,Sink,Media,Socket";
        };
      };

      services.blueman.enable = true;
    };
}

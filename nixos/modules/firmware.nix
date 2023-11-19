{
  pkgs,
  config,
  lib,
  ...
}:
with pkgs;
with lib; let
  cfg = config.modules.hardware.firmware;
in {
  config = {
    # Enable all unfree hardware support.
    hardware.firmware = with pkgs; [firmwareLinuxNonfree];
    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;

    # Enable firmware update service
    services.fwupd.enable = true;
  };
}

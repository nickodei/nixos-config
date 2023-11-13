{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.hardware.docker;
in {
  options.modules.hardware.docker = {
    enable = mkEnableOption "Bluetooth";
    nvidia = mkEnableOption "Enable Nvidia-GPU in docker";
  };

  config =
    mkIf cfg.enable
    {
      virtualisation.docker.enable = true;
      virtualisation.docker.enableNvidia = cfg.nvidia;
    };
}

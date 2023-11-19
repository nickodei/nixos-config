{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.hardware.audio;
in {
  options.modules.hardware.audio = {
    enable = mkEnableOption "Audio";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #wireplumber.enable = true;
    };

    users.users.main.extraGroups = ["audio"];
  };
}

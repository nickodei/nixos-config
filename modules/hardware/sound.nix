{ options, config, lib, pkgs, user, ... }:

with lib;
let cfg = config.modules.hardware.audio;
in
{
  options.modules.hardware.audio = {
    enable = mkEnableOption "Audio";
  };

  config = mkIf cfg.enable {

    # Basic services
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Better bluetooth configuration
    environment.etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
        	["bluez5.enable-sbc-xq"] = true,
        	["bluez5.enable-msbc"] = true,
        	["bluez5.enable-hw-volume"] = true,
        	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '';
    };

    users.users.${user}.extraGroups = [ "audio" ];
  };
}

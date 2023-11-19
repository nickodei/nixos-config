{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.hardware.graphics;
in {
  options.modules.hardware.graphics = {
    gpu = mkOption {
      type = types.enum ["amd" "intel" "nvidia" "none"];
      default = "none";
      description = "The primary gpu on your system that you want your desktop to display on";
    };
  };

  config = let
    amd = cfg.gpu == "amd";
    intel = cfg.gpu == "intel";
    nvidia = cfg.gpu == "nvidia";
  in {
    boot.initrd.kernelModules = [(mkIf amd "amdgpu")];

    services.xserver = mkIf xorg {
      videoDrivers = [
        (mkIf amd "amdgpu")
        (mkIf intel "intel")
        (mkIf nvidia "nvidia")
      ];

      deviceSection = mkIf (intel || amd) ''
        Option "TearFree" "true"
      '';

      enable = true;
      libinput.enable = true;
    };

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [
        (mkIf amd amdvlk)
        (mkIf intel intel-media-driver)
        (mkIf intel vaapiIntel)
        (mkIf intel vaapiVdpau)
        (mkIf intel libvdpau-va-gl)

        libva
      ];
    };
  };
}

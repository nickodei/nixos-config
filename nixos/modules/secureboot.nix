{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.hardware.secureboot;
in {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  options.modules.hardware.secureboot = {
    enable = mkEnableOption "Secureboot";
  };

  config =
    mkIf cfg.enable
    {
      environment.systemPackages = [
        # For debugging and troubleshooting Secure Boot.
        pkgs.sbctl
      ];

      boot.loader.systemd-boot.enable = lib.mkForce false;
      boot.lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };
}

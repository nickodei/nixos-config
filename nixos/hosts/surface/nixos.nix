{inputs, ...}: {
  imports = [
    ../../modules
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  networking.hostName = "surface";

  modules.hardware = {
    bluetooth.enable = true;
    secureboot.enable = true;
    graphics.gpu = "intel";
  };
}

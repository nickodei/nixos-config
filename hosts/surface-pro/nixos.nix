{ inputs, config, pkgs, lib, ... }:

{
  imports = [ 
    ../shared.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p7";
      preLVM = true;
    };
  };

  system.stateVersion = "23.05";
}
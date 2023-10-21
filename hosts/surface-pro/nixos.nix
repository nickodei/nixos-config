{ inputs, config, pkgs, lib, ... }:

{
  imports = [ 
    ../shared.nix
    ./hardware-configuration.nix
    #inputs.lanzaboote.nixosModules.lanzaboote
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  #boot.loader.systemd-boot.enable = lib.mkForce false;
  #boot.lanzaboote = {
  #  enable = true;
  #  pkiBundle = "/etc/secureboot";
  #};

  #boot.bootspec.enable = true;
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p7";
      preLVM = true;
    };
  };

  hardware.opengl.enable = true;
  boot.loader = {
    grub = {
	devices = ["nodev"];
	efiSupport = true;
	enable = true;
	useOSProber = true;
    };
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}


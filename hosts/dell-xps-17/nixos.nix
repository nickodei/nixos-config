{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../shared.nix
    ./hardware-configuration.nix
    ../../modules/hardware/imports.nix
    inputs.nixos-hardware.nixosModules.dell-xps-17-9700-nvidia
  ];

  modules = {
    hardware.nvidia.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

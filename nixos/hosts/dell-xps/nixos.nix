{inputs, ...}: {
  imports = [
    ../../modules
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-17-9700-nvidia
  ];

  networking.hostName = "dell-xps";
}

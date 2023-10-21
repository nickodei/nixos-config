{ inputs, config, pkgs, lib, ... }:

{
  imports = [ 
    ../shared.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  system.stateVersion = "23.05";
}

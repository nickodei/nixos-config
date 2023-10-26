{ inputs, pkgs, config, ... }:

{
  imports = [
      ./sound.nix
      ./bluetooth.nix
  ];
}


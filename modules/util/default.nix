{ inputs, pkgs, config, ... }:

{
  imports = [
      ./git
      ./monitors.nix
  ];
}
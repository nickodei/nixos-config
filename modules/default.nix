{ inputs, pkgs, config, ... }:

{
  imports = [
      ./browser
      ./shell
      ./terminal
  ];
}
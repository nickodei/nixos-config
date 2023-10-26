{ inputs, pkgs, config, ... }:

{
  imports = [
    ./spotify.nix
    ./obsidian.nix
    ./blueman-applet.nix
  ];
}


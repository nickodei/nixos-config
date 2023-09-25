{
  description = "NixOS systems and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    mkSystem = import ./lib/mksystem.nix;
  in {
    nixosConfigurations.dell-xps = mkSystem "dell-xps" rec {
      inherit nixpkgs home-manager;
      system = "x86_64-linux";
      user   = "niek";
    };
  };
}
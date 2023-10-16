{
  description = "NixOS systems and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    nurpkgs.url = "github:nix-community/NUR";
  }; 

  outputs = { self, nixpkgs, home-manager, hyprland,  nixos-hardware, ... }@inputs: let
    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
    };
  in {
    nixosConfigurations.work = mkSystem "dell-xps" rec {
      system = "x86_64-linux";
      user   = "niek";
    };
  };
}
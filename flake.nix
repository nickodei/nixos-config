{
  description = "NixOS systems and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  }; 

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: let
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
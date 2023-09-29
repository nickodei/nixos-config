{
  description = "NixOS systems and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
   # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

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
   #  nixpkgs.config.allowUnfree = true;
   # nixpkgs-unstable.config.allowUnfree = true;   
 

    nixosConfigurations.work = mkSystem "dell-xps" rec {
      system = "x86_64-linux";
      user   = "niek";
    };
  };
}
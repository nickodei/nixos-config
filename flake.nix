{
  description = "NixOS systems and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    nixosConfigurations = {
      dell-xps = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/hosts/dell-xps/nixos.nix
        ];
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
      };

      surface = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/hosts/surface/nixos.nix
        ];
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      "dell-xps@work" = home-manager.lib.homeManagerConfiguration {
        modules = [./users/work/home.nix];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "main@surface" = home-manager.lib.homeManagerConfiguration {
        modules = [./users/main/home.nix];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}

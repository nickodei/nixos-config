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
    lib = nixpkgs.lib // home-manager.lib;
	systems = [ "x86_64-linux" ];
	forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
  in {
    inherit lib;

    nixosConfigurations = {
      dell-xps = lib.nixosSystem {
        modules = [
          ./hosts/dell-xps-17/nixos.nix
          ./users/work/home.nix
        ];
        specialArgs = {inherit inputs outputs;};
      };

      surface = lib.nixosSystem {
        modules = [
          ./hosts/surface-pro/nixos.nix
          ./users/main/nixos.nix
        ];
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      "dell-xps@work" = lib.homeManagerConfiguration {
        modules = [./users/work/home.nix];
		pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "surface@main" = lib.homeManagerConfiguration {
        modules = [./users/main/home.nix];
		pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}

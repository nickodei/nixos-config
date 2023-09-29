{ nixpkgs, inputs }:

# This function creates a NixOS system based on our VM setup for a
# particular architecture.
name: {
  system,
  user
}:

let
  # The config files for this system.
in nixpkgs.lib.nixosSystem rec {
  inherit system;

  specialArgs = {inherit inputs user;};
  modules = [
    ../hosts/${name}
    ../users/${user}/nixos.nix
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {inherit inputs user;};
      home-manager.users.${user} = import ../users/${user}/home-manager.nix;
    }
  ];
}

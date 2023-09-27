{ nixpkgs, inputs }:

# This function creates a NixOS system based on our VM setup for a
# particular architecture.
name: {
  system,
  user
}:

let
  # The config files for this system.
  machineConfig = ../hosts/${name};
  userOSConfig = ../users/${user}/nixos.nix;
  userHMConfig = ../users/${user}/home-manager.nix;

in nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    machineConfig
    userOSConfig
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {inherit inputs;};
      home-manager.users.${user} = import userHMConfig;
    }
  ];
}

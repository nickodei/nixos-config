# This function creates a NixOS system based on our VM setup for a
# particular architecture.
name: {
  nixpkgs,
  home-manager,
  system,
  user
}:

let
  # The config files for this system.
  machineConfig = ../hosts/${name}/hardware-configuration.nix;
  userOSConfig = ../users/${user}/nixos.nix;
  userHMConfig = ../users/${user}/home-manager.nix;
in nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    machineConfig
    userOSConfig
    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import userHMConfig { };
    }

    {
      config._module.args = {
        currentSystem = system;
        currentSystemName = name;
        currentSystemUser = user;
      };
    }
  ];
}
# {
#   nixpkgs,
#   inputs,
# }: {
#   nixConfig,
#   host,
#   system,
# }: let
#   host-module = ../hosts/${host}/nixos.nix;
#   user-module = ../users/${user}/nixos.nix;
# in
#   nixpkgs.lib.nixosSystem rec {
#     inherit system;
#
#     modules = [
#       host-module
#       user-module
#       inputs.home-manager.nixosModules.home-managerlib
#       {
#         home-manager.useGlobalPkgs = true;
#         home-manager.useUserPackages = true;
#         home-manager.extraSpecialArgs = {inherit inputs user host nixConfig;};
#         home-manager.users.${user} = import ../users/${user}/home.nix;
#       }
#     ];
#     specialArgs = {inherit inputs user host nixConfig;};
#  }
{}

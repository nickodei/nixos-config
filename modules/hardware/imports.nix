{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./sound.nix
    ./bluetooth.nix
    ./nvidia.nix
    ./docker.nix
  ];
}

{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./git
    ./scripts/imports.nix
  ];
}

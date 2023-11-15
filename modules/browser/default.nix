{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./firefox
    ./chromium/chromium.nix
  ];
}

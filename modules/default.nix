{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./browser
    ./shell
    ./terminal
    ./editor
    ./util
    ./desktop
    ./development
    ./launcher
  ];
}

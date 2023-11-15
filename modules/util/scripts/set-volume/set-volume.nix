{pkgs}:
pkgs.writeShellApplication {
  name = "set-volume";
  runtimeInputs = [pkgs.libnotify];
  text = builtins.readFile ./set-volume.sh;
}

{pkgs}:
pkgs.writeShellApplication {
  name = "set-volume";
  runtimeInputs = [pkgs.libnotify pkgs.pamixer];
  text = builtins.readFile ./set-volume.sh;
}

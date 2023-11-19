{...}: {
  import = [
    ./nix.nix
    ./users.nix
    ./ssh.nix
    ./console.nix
    ./networking.nix
    ./bluetooth.nix
    ./secureboot.nix
    ./boot.nix
    ./gpu.nix
    ./firmware.nix
  ];
}

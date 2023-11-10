{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../shared.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-17-9700-nvidia
  ];

  boot.loader.systemd-boot.enable = true;

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
  };

  # Nvidia
  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver.videoDrivers = ["nvidia"];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

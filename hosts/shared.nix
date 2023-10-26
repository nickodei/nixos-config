{ inputs, config, pkgs, ... }:

{
  # Use the grub EFI boot loader.
  hardware.opengl.enable = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      useOSProber = true;
    };
  };

  # Network-manager
  systemd.services.NetworkManager-wait-online.enable = false;
  networking = {
    networkmanager.enable = true;
    dhcpcd.wait = "background";
  };

  # Console
  i18n.defaultLocale = "de_DE.UTF-8";
  console.keyMap = "de";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;
 }

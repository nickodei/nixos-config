{ inputs, config, pkgs, ... }:

{
    # Use the systemd-boot EFI boot loader.
    #boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

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

    # Pipewire
    services.pipewire.enable = true;

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    # Bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.settings = {
        General = {
            Enable = "Source,Sink,Media,Socket";
        };
    };
}

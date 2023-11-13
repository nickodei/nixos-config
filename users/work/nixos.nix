{
  lib,
  pkgs,
  config,
  user,
  ...
}: {
  imports = [
    ../../modules/hardware/imports.nix
  ];

  modules = {
    hardware.audio.enable = true;
    hardware.bluetooth.enable = true;
    hardware.docker = {
      enable = true;
      nvidia = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gnumake
    unzip
    swaylock-effects
    pamixer
    networkmanagerapplet
    brightnessctl
    neofetch
    wl-clipboard
    libva
    xwayland
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firfox";
    TERMINAL = "kitty";

    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    WLR_RENDERER = "vulkan";

    LIBSEAT_BACKEND = "logind";

    # Mozilla
    NVD_BACKEND = "direct";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    MOZ_LOG = "PlatformDecoderModule:5";

    NIXOS_OZONE_WL = "1";
  };

  networking.extraHosts = ''
    127.0.0.1 re-invent.lc
  '';

  environment.shells = with pkgs; [fish];

  fonts.packages = with pkgs; [
    inter
    (nerdfonts.override {fonts = ["SourceCodePro"];})
    fira-code
  ];

  security.polkit.enable = true;

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];

  services.dbus.enable = true;

  nixpkgs.config.allowUnfree = true;
  programs.fish = {
    enable = true;
    loginShellInit = ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
    '';
  };

  programs.thunar.enable = true;

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  ##-----------
  ## Users
  ##-----------
  users.users.root = {
    hashedPassword = "$6$O.0kGRxN0suxw3GV$69okbAGk4peoBUWI42kxEbEYVgom/324.xIOpVPFtFJzS/fiolGqt3ek4gxCRhDYJXSxq/q97ws6JRpDG7MAy0";
  };

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.fish;
    home = "/home/${user}";
    extraGroups = ["docker" "wheel" "video" "networkmanager" "input" "tty" "root"];
    hashedPassword = "$6$O.0kGRxN0suxw3GV$69okbAGk4peoBUWI42kxEbEYVgom/324.xIOpVPFtFJzS/fiolGqt3ek4gxCRhDYJXSxq/q97ws6JRpDG7MAy0";
  };
}

{ pkgs,  ... }:

{
  imports = [
    ../../modules/waybar
    ../../modules/hyprland
    ../../modules/hyprpaper
    #../../modules/zsh
  ];

  environment.systemPackages = with pkgs; [
    hyprland
    gnumake
    neofetch
    obsidian
    spotify
    libva
    jetbrains.rider
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
  ];

  environment.sessionVariables = {
    EDITOR = "code";
    BROWSER = "firfox";
    TERMINAL = "kitty";

    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    CLUTTER_BACKEND = "wayland";
    WLR_RENDERER = "vulkan";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";

    NIXOS_OZONE_WL = "1";
    LIBSEAT_BACKEND = "logind";

    # Mozilla
    NVD_BACKEND="direct"; 
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DISABLE_RDD_SANDBOX="1";
    MOZ_LOG="PlatformDecoderModule:5";

    LIBVA_DRIVER_NAME = "nvidia";
  };

  environment.shells = with pkgs; [ fish ];

  fonts.packages = with pkgs; [
    inter
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

  security.polkit.enable = true;

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  nixpkgs.config.allowUnfree = true;
  programs.fish = {
    enable = true;
    loginShellInit = ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
    '';
  };

  ##-----------
  ## Users
  ##-----------
  users.users.root = {
    hashedPassword = "$6$O.0kGRxN0suxw3GV$69okbAGk4peoBUWI42kxEbEYVgom/324.xIOpVPFtFJzS/fiolGqt3ek4gxCRhDYJXSxq/q97ws6JRpDG7MAy0";
  };

  users.users.niek = {
    isNormalUser = true;
    shell = pkgs.fish;
    home = "/home/niek";
    extraGroups = [ "docker" "wheel" ];
    hashedPassword = "$6$O.0kGRxN0suxw3GV$69okbAGk4peoBUWI42kxEbEYVgom/324.xIOpVPFtFJzS/fiolGqt3ek4gxCRhDYJXSxq/q97ws6JRpDG7MAy0";
  };
}

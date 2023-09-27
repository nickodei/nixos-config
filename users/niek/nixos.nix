{ pkgs, ... }:

{
  imports = [../../modules/waybar];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  environment.systemPackages = with pkgs; [
    hyprland
    swww
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
  ];

  environment.sessionVariables = {
    EDITOR = "code";
    BROWSER = "firfox";
    TERMINAL = "kitty";

   # GBM_BACKEND= "nvidia-drm";
   # __GLX_VENDOR_LIBRARY_NAME= "nvidia";
   # LIBVA_DRIVER_NAME= "nvidia"; # hardware acceleration
   # __GL_VRR_ALLOWED="1";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    CLUTTER_BACKEND = "wayland";
    WLR_RENDERER = "vulkan";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";




    #MOZ_ENABLE_WAYLAND = "1";
    #LIBVA_DRIVER_NAME = "nvidia";
    #MOZ_DISABLE_RDD_SANDBOX = "1";
    #XDG_CURRENT_DESKTOP = "hyprland";
#
    ##LIBVA_DRIVER_NAME="nvidia";
    ##MOZ_DISABLE_RDD_SANDBOX=1;
#
#
#
    NIXOS_OZONE_WL = "1";
    LIBSEAT_BACKEND = "logind";
#
    #XCURSOR_SIZE="16";
#
    #_JAVA_AWT_WM_NONREPARENTING = "1";
  };

  fonts.fonts = with pkgs; [
    nerdfonts
    meslo-lgs-nf
  ];

  security.polkit.enable = true;
  

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  ##-----------
  ## Users
  ##-----------
  users.users.root = {
    hashedPassword = "$6$O.0kGRxN0suxw3GV$69okbAGk4peoBUWI42kxEbEYVgom/324.xIOpVPFtFJzS/fiolGqt3ek4gxCRhDYJXSxq/q97ws6JRpDG7MAy0";
  };

  users.users.niek = {
    isNormalUser = true;
    home = "/home/niek";
    extraGroups = [ "docker" "wheel" ];
    hashedPassword = "$6$O.0kGRxN0suxw3GV$69okbAGk4peoBUWI42kxEbEYVgom/324.xIOpVPFtFJzS/fiolGqt3ek4gxCRhDYJXSxq/q97ws6JRpDG7MAy0";
    openssh.authorizedKeys.keyFiles = [
      /home/niek/.ssh/authorized_keys
    ];
  };
}

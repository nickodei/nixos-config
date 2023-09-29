
{ config, pkgs, inputs, ... }:

{ 
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  # Home - Default Settings
  home.username = "niek";
  home.homeDirectory = "/home/niek";

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.pointerCursor = {
    name = "Adwaita";
    size = 32;
    package = pkgs.gnome.adwaita-icon-theme;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  # Programs
  programs.git = {
    enable = true;
    userName  = "Niek Deibus";
    userEmail = "nickdeibus@outlook.de";
  };

  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
    };
    font.name = "SauceCodePro NFM";
    shellIntegration.mode = "enabled";
    shellIntegration.enableZshIntegration = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };

  programs.firefox = {
    enable = true;
  };
}

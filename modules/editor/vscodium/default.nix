{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.vscodium;
in
{
  options.modules.vscodium = {
    enable = lib.mkEnableOption "vscodium";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
      ];
      userSettings = {
        editor.fontFamily = "'SauceCodePro Nerd Font'";
        workbench.colorTheme = "Catppuccin Mocha";
        window.titleBarStyle = "custom";
        catppuccin.accentColor = "lavender";
        catppuccin.customUIColors = {
          mocha = {
            statusBar.foreground = "accent";
          };
        };
        window.zoomLevel = 1;
        workbench.startupEditor = "none";
      };
    };
  };
}


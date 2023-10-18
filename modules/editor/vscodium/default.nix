{ inputs, pkgs, lib, config, ... }:

let
    cfg = config.modules.vscodium;
in {
    options.modules.vscodium = { 
        enable = lib.mkEnableOption "vscodium"; 
    };

    config = lib.mkIf cfg.enable {
        programs.vscode = {
            enable = true;
            package = pkgs.vscodium;
            extensions = with pkgs.vscode-extensions; [
                bbenoist.nix
                catppuccin.catppuccin-vsc
                catppuccin.catppuccin-vsc-icons
            ];
            userSettings = {
                editor.fontFamily = "'SauceCodePro Nerd Font'";
                workbench.colorTheme = "Catppuccin Mocha";
                workbench.iconTheme = "catppuccin-mocha";
                window.titleBarStyle = "custom";
                catppuccin.accentColor = "lavender";
                catppuccin.customUIColors = {
                    mocha = {
                        statusBar.foreground = "accent";
                    };
                };
                editor.semanticHighlighting.enabled = true;
                terminal.integrated.minimumContrastRatio = 1;
                window.zoomLevel = 1;
                workbench.startupEditor = "none";
            };
        };
    };
}
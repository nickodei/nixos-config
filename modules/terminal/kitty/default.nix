{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.kitty;
in {
  options.modules.kitty = { 
    enable = lib.mkEnableOption "fish"; 
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        window_padding_width = 5;
      };
      theme = "Catppuccin-Mocha";
      font.name = "SauceCodePro NFM";
      shellIntegration.mode = "enabled";
      shellIntegration.enableFishIntegration = true;
    };
  };
}
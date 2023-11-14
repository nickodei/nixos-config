{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.mako;
in {
  options.modules.mako = {
    enable = lib.mkEnableOption "Mako";
  };

  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;
      defaultTimeout = 4000;

      # styling
      backgroundColor = "#282a36";
      textColor = "#ffffff";
      borderColor = "#282a36";
    };
  };
}

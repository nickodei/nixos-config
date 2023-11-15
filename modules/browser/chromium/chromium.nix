{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.chromium;
in {
  options.modules.chromium = {
    enable = lib.mkEnableOption "Chrome Browser";
  };

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
    };
  };
}

{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.mako;
in
{
  options.modules.mako = {
    enable = lib.mkEnableOption "Mako";
  };

  config = lib.mkIf cfg.enable {
    programs.mako = {
      enable = true;
      defaultTimeout = 4000;
    };
  };
}


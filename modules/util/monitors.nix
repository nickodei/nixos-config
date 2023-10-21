{ lib, config, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.available-monitors = {
    surface-pro-8 = {
      name = "eDP-1";
      width = 2880;
      height = 1920;
      refreshRate = 60;
      x = 0;
      y = 0;
      scale = 2;
      enabled = true;
    };
    dell-xps-17 = {
      name = "eDP-1";
      width = 3840;
      height = 2400;
      refreshRate = 60;
      x = 0;
      y = 0;
      scale = 2;
      enabled = true;
    };
  };

  options.monitors = mkOption {
    type = types.listOf (types.submodule {
      options = {
        name = mkOption {
          type = types.str;
          example = "DP-1";
        };
        width = mkOption {
          type = types.int;
          example = 1920;
        };
        height = mkOption {
          type = types.int;
          example = 1080;
        };
        refreshRate = mkOption {
          type = types.int;
          default = 60;
        };
        x = mkOption {
          type = types.int;
          default = 0;
        };
        y = mkOption {
          type = types.int;
          default = 0;
        };
        scale = mkOption {
          type = types.int;
          default = 1;
        };
        enabled = mkOption {
          type = types.bool;
          default = true;
        };
      };
    });
    default = [ ];
  };
}
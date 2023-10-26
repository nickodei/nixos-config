{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.obsidian;
in
{
  options.modules.obsidian = {
    enable = mkEnableOption "Obsidian";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ obsidian ];
  };
}

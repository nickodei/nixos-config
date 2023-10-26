{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.spotify;
in
{
  options.modules.spotify = {
    enable = mkEnableOption "Spotify";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ spotify ];
  };
}

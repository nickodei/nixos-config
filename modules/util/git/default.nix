{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.git;
in {
  options.modules.git = { 
    enable = lib.mkEnableOption "git"; 
  };

  config = lib.mkIf cfg.enable {
      programs.git = {
        enable = true;
        userName  = "Niek Deibus";
        userEmail = "nickdeibus@outlook.de";
      };
  };
}
{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.fish;
in {
  options.modules.fish = { 
    enable = lib.mkEnableOption "fish"; 
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      shellAbbrs = {
        ll = "ls -l";
        test = "sudo nixos-rebuild test --flake /home/niek/nixos-config#work";
        update = "sudo nixos-rebuild switch --flake /home/niek/nixos-config#work";
      };
    };
  };
}
{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.fish;
in
{
  options.modules.fish = {
    enable = lib.mkEnableOption "fish";
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        eval "$(direnv hook fish)"
      '';
      shellAbbrs = {
        config = "nvim ~/nixos-config";
        #nix-test = "sudo nixos-rebuild test --flake ~/nixos-config#${nixConfig}";
        #nix-switch = "sudo nixos-rebuild switch --flake ~/nixos-config#${nixConfig}";
        ll = "ls -l";
      };
    };
  };
}


{ config, lib, pkgs, user, ... }:

{
    programs.zsh = {
        enable = true;
        shellAliases = {
            ll = "ls -l";
            update = "sudo nixos-rebuild switch --flake /etc/home/niek/nixos-config#work";
        };
        ohMyZsh = {
            enable = true;
            plugins = [ "git" "thefuck" ];
            theme = "robbyrussell";
        };
    };
}
{ config, lib, pkgs, user, ... }:

{
    home-manager.users.${user} = {
        programs.zsh = {
            enable = true;
            shellAliases = {
                ll = "ls -l";
                update = "sudo nixos-rebuild switch --flake /etc/home/niek/nixos-config#work";
            };
            histSize = 10000;
            histFile = "~/.config/zsh/history";
            ohMyZsh = {
                enable = true;
                plugins = [ "git" "thefuck" ];
                theme = "robbyrussell";
            };
        };
    };
}
{ config, lib, pkgs, user, ... }:

{
    home-manager.users.${user} = {
        programs.zsh = {
            enable = true;
            shellAliases = {
                ll = "ls -l";
                update = "sudo nixos-rebuild switch --flake /home/niek/nixos-config#work";
            };
	};
    };
}

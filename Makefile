test-work:
	sudo nixos-rebuild test --flake .#work

build-work:
	sudo nixos-rebuild switch --flake .#work
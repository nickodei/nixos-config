{
  inputs,
  lib,
  ...
}: {
  nix = {
    trusted-users = ["root" "@wheel"];
    auto-optimise-store = lib.mkDefault true;
    experimental-features = ["nix-command" "flakes" "repl-flake"];
  };

  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than +3"; # Keep the last 3 generations
  };

  nixpkgs.config.allowUnfree = true;
}

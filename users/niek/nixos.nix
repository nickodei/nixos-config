{ pkgs, ... }:

{
  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  users.users.niek = {
    isNormalUser = true;
    home = "/home/niek";
    extraGroups = [ "docker" "wheel" ];
    hashedPassword = "$6$O.0kGRxN0suxw3GV$69okbAGk4peoBUWI42kxEbEYVgom/324.xIOpVPFtFJzS/fiolGqt3ek4gxCRhDYJXSxq/q97ws6JRpDG7MAy0";
  };
}
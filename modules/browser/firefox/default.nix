{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.modules.firefox;
in
{
  options.modules.firefox = {
    enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles = {
        niek = {
          settings = {
            "browser.display.background_color" = "#${config.colorScheme.colors.base00}";
            "browser.toolbars.bookmarks.visibility" = "never";
          };
          bookmarks = [
            {
              name = "TUM";
              toolbar = false;
              bookmarks = [
                {
                  name = "TUM Online";
                  url = "https://campus.tum.de/tumonline/ee/ui/ca2/app/desktop/#/home?$ctx=design=ca;lang=de";
                  tags = [ "tum" ];
                  keyword = "tum-online";
                }
                {
                  name = "TUM Moodle";
                  tags = [ "tum" ];
                  keyword = "tum-moodle";
                  url = "https://www.moodle.tum.de/my/";
                }
                {
                  name = "TUM Live";
                  tags = [ "tum" ];
                  keyword = "tum-live";
                  url = "https://live.rbg.tum.de/";
                }
                {
                  name = "GitLab LRZ";
                  tags = [ "tum" "gitlab" "lrz" ];
                  keyword = "lrz";
                  url = "https://gitlab.lrz.de/";
                }
              ];
            }
            {
              name = "NixOS";
              toolbar = false;
              bookmarks = [
                {
                  name = "Configurations";
                  tags = [ "nixos" "nix" ];
                  keyword = "config";
                  url = "https://mynixos.com";
                }
              ];
            }
          ];
          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [

          ];
        };
      };
    };
  };
}

#programs.firefox = {
#  enable = true;
#  profiles = {
#    niek = {
#      #extensions = with pkgs.nur.repos.rycee.firefox-addons; [
#      #  catppuccin-mocha-lavender
#      #];

#    };
#  };
#
#
#  #profiles."niek" = {
#  #  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
#  #    catppuccin catppuccin-mocha-lavender-
#  #  ];
#  #};
#};


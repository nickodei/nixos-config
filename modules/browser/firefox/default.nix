{ inputs, pkgs, lib, config, ... }:

let
    cfg = config.modules.firefox;
in {
    options.modules.firefox = { 
        enable = lib.mkEnableOption "firefox"; 
    };

    config = lib.mkIf cfg.enable {
        programs.firefox = {
            enable = true;
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
  #      bookmarks = [
  #        {
  #          name = "TUM";
  #          toolbar = true;
  #          bookmarks = [
  #            {
  #              name = "TUM Online";
  #              url = "https://campus.tum.de/tumonline/ee/ui/ca2/app/desktop/#/home?$ctx=design=ca;lang=de";
  #            }
  #            {
  #              name = "TUM Moodle";
  #              url = "https://www.moodle.tum.de/my/";
  #            }
  #            {
  #              name = "TUM Live";
  #              url = "https://live.rbg.tum.de/";
  #            }
  #          ];
  #        }
  #        {
  #          name = "NixOS";
  #          toolbar = true;
  #          bookmarks = [
  #            {
  #              name = "Configurations";
  #              url = "https://mynixos.com";
  #            }
  #          ];
  #        }
  #      ];
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
{ config, lib, pkgs, vars, nur, ... }:

{
  # Add options for firefox system monitor
  options = {
    firefox.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable firefox.
      '';
    }; 
  };

  # Install firefox if desired
  config = lib.mkIf config.firefox.enable {
    home-manager.users.${vars.user} = {
      # Configure Firefox web browser
      programs.firefox = {

        # Install Firefox
        enable = true;

        # Use nightly version of firefox
        package = pkgs.firefox-wayland;

        # Configure user profiles
        profiles.${vars.user} = {
          id = 0;
          isDefault = true;

          # Profile settings
          settings = {

            # Disable the Firefox new-tab-page
            "browser.newtabpage.enabled" = false;

            # Set startup page
            # 0=blank, 1=home, 2=last visited page, 3=resume previous session
            "browser.startup.page" = 3;

            # Set a blank homepage
            "browser.startup.homepage" = "http://alpine-docker.tail025bf6.ts.net:7575/board/default%20VPN";

            # Allow tiling of fullscreen windows
            "full-screen-api.ignore-widgets" = true;

            # Disable popup when mic or webcam is active
            #"privacy.webrtc.legacyGlobalIndicator" = false;
          };

          extensions = lib.mkIf config.programs.firefox.enable (with nur.repos; [
            rycee.firefox-addons.bitwarden
            rycee.firefox-addons.protondb-for-steam
            rycee.firefox-addons.i-dont-care-about-cookies
            rycee.firefox-addons.greasemonkey
            rycee.firefox-addons.instant-gaming
            rycee.firefox-addons.ad-speedup
            rycee.firefox-addons.speedvitals
            rycee.firefox-addons.lighthouse
            rycee.firefox-addons.lighthouse-report-generator
            rycee.firefox-addons.plasma-integration
            #rycee.firefox-addons.ublock-origin
            #sigprof.firefox-esr-langpack-de
            #sigprof.firefox-esr-langpack-es-MX
          ]);
        };
      };

      # Set environment variables
      home.sessionVariables = {

        # Use wayland version of firefox
        MOZ_ENABLE_WAYLAND = 1;
      };
    };
  };
}

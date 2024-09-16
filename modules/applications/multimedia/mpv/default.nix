{ config, lib, pkgs, vars, ... }:

{
  # Add options for mpv
  options = {
    mpv.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable mpv.
      '';
    }; 
  };

  # Install mpv if desired
  config = lib.mkIf config.mpv.enable {
    home-manager.users.${vars.user} = {
      # Configure mpv media player
      programs.mpv = {

        # Enable mpv
        enable = true;

        # Install custom scripts
        scripts = with pkgs; [
          mpvScripts.uosc
        ];

        # Script configuration
        scriptOpts."uosc" = {

          # Style of timeline
          "timeline_style" = "bar";

          # Volume to step when scrolling
          "volume_step" = 5;
        };
      };
    };
  };
}

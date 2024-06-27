_: { config, lib, pkgs, ... }:

{
  # Install mpv if desired
  config = lib.mkIf config.mpv.enable {

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
}

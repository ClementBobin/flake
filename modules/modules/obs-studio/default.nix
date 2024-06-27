_: { config, lib, pkgs, ... }:

{
  # Install obs-studio if desired
  config = lib.mkIf config.obs-studio.enable {

    # Configure OBS studio
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
      ];
    };
  };
}

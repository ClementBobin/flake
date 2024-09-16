{ config, lib, pkgs, vars, ... }:

{
  # Add options for obs-studio and openshot-qt
  options = {
    obs-studio.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable obs-studio
      '';
    }; 
    openshot.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable openshot-qt
      '';
    }; 
  };

  # Install obs-studio and openshot-qt if desired
  config = {
    home-manager.users.${vars.user} = lib.mkMerge [
      (lib.mkIf config.obs-studio.enable {
        programs.obs-studio = {
          enable = true;
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
          ];
        };
      })
      (lib.mkIf config.openshot.enable {
        home.packages = [
          pkgs.openshot-qt
        ];
      })
    ];
  };
}

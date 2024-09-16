{ config, pkgs, lib, vars, ... }:

{
  # Add options for sway-notification-center
  options = {
    sway-notification-center.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable sway-notification-center.
      '';
    }; 
  };

  # Install sway-notification-center if desired
  config = lib.mkIf (config.sway.enable && config.sway-notification-center.enable) {
    home-manager.users.${vars.user} = {

      # Manage sway notification center settings
      xdg.configFile."swaync/config.json".source = ./config.json;
      xdg.configFile."swaync/style.css".source = ./style.css;

      # Install Sway Notification Center
      home.packages = [
        pkgs.swaynotificationcenter
      ];
    };
  };
}

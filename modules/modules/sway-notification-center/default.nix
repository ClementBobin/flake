_: { config, pkgs, lib, ... }:

{
  # Install sway-notification-center if desired
  config = lib.mkIf (config.sway.enable && config.sway-notification-center.enable) {

    # Install Sway Notification Center
    home.packages = [
      pkgs.swaynotificationcenter
    ];

    # Manage sway notification center settings
    xdg.configFile."swaync/config.json".source = ./config.json;
    xdg.configFile."swaync/style.css".source = ./style.css;
  };
}

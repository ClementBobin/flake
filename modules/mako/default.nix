{ config, lib, pkgs, vars, ... }:

{
  # Add options for mako
  options = {
    mako.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable and configure mako notification daemon.
      '';
    };

    mako.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install and configure mako via home-manager or directly in the system environment.
      '';
    };
  };

  # Apply mako configuration if enabled
  config = lib.mkIf config.mako.enable (lib.mkMerge [

    # Mako configuration via home-manager
    (lib.mkIf (config.mako.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Configure Mako notification daemon
        services.mako = {
          # Enable mako
          enable = true;

          # Notification display settings
          maxVisible = 5;
          sort = "-time";

          # Allow programs to assign on-click actions
          actions = true;

          # Positioning and size
          anchor = "top-right";
          layer = "overlay";
          height = 200;
          width = 500;
          margin = "20,20,20,20";
          padding = "12,12,12,12";
          borderSize = 3;
          borderRadius = 25;

          # Layout of notification
          markup = true;
          format = ''
            <b>%s</b>\n%b
          '';

          # Icons
          icons = true;
          maxIconSize = 96;

          # Font
          font = "sans-serif 12";
        };
      };
    })

    # Mako configuration directly in the system environment
    (lib.mkIf (config.mako.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        mako
      ];

      # Configure Mako notification daemon using systemd service
      systemd.services.mako = {
        description = "Mako - Notification Daemon";
        wantedBy = [ "default.target" ];
        serviceConfig.ExecStart = "${pkgs.mako}/bin/mako";
        # You may need additional configuration here if required
      };
    })

  ]);
}

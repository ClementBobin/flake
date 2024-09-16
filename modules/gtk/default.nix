{ config, lib, pkgs, vars, ... }:

{
  # Add options for GTK configuration
  options = {
    gtk.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable and configure GTK settings.
      '';
    };

    gtk.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to apply GTK configuration via home-manager or directly in the system environment.
      '';
    };
  };

  # Apply GTK configuration if enabled
  config = lib.mkIf config.gtk.enable (lib.mkMerge [

    # GTK configuration via home-manager
    (lib.mkIf (config.gtk.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # GTK configuration
        gtk = {
          # Set GTK font settings
          font = {
            name = "Ubuntu";
            size = 12;
          };
        };

        # Set environment variables for GTK
        home.sessionVariables = {
          GDK_BACKEND = "wayland";
        };
      };
    })

    # GTK configuration directly in the system environment
    (lib.mkIf (config.gtk.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        # Add any packages needed for GTK configuration if required
        # Example: gtk3
        pkgs.gtk3
      ];

      # Set environment variables for GTK
      # This example assumes you are using an X11 environment. Adjust accordingly for Wayland.
      environment.sessionVariables = {
        GDK_BACKEND = "wayland";
      };
    })

  ]);
}

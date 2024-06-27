_: { config, lib, pkgs, ... }:

{

  # Configure Gtk if desired
  config = lib.mkIf config.gtk.enable {

    # Configure Gtk
    gtk = {

      # Enable Gtk configuration
      enable = true;

      # Set font
      font = {
        name = "Ubuntu";
        size = 12;
      };
    };

    # Set environment variables
    home.sessionVariables = {
      GDK_BACKEND = "wayland";
    };
  };
}

{ config, lib, pkgs, vars, ... }:

{
  # Add options for qt.config
  options = {
    qt.config.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable qt.config
      '';
    };
    qt.config.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install Qt configuration via home-manager or directly in the environment.
      '';
    }; 
  };


  # Configure qt if desired
  config = lib.mkIf config.qt.config.enable (lib.mkMerge [

    # Qt configuration for home-manager
    (lib.mkIf (config.qt.config.installMethod == "home-manager") {
      environment.systemPackages = with pkgs; [
        qt5ct
      ];
      home-manager.users.${vars.user} = {

        # Configure qt5
        # Note that we use .text here so that theming can append to it
        xdg.configFile."qt5ct/qt5ct.conf".text = builtins.readFile ./qt5ct.conf;

        # Set environment variables
        home.sessionVariables = {
          QT_QPA_PLATFORM = "wayland";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        };
      };
    })

    # Qt configuration for system environment
    (lib.mkIf (config.qt.config.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        qt5ct
      ];

      # Configure qt5
      # Note that we use .text here so that theming can append to it
      #xdg.configFile."qt5ct/qt5ct.conf".text = builtins.readFile ./qt5ct.conf;

      # Ensure Qt environment variables are set
      environment.variables = {
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      };

      # Configure qt5ct if needed
      # Note: System-wide configuration might require additional setup
    })

  ]);
}

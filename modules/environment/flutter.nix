{ config, pkgs, vars, lib, ... }:

{
  # Add options for Flutter
  options = {
    flutter.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable flutter.
      '';
    };
    flutter.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install flutter via home-manager or directly in the environment.
      '';
    };
  };

  # Install flutter if desired
  config = lib.mkIf config.flutter.enable (lib.mkMerge [

    # flutter config for home-manager
    (lib.mkIf (config.flutter.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Install flutter packages
        home.packages = with pkgs; [
            flutter
            android-studio
        ];
      };
    })

    # flutter config for environment
    (lib.mkIf (config.flutter.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        flutter
        android-studio
      ];
    })
  ]);
}

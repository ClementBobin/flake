{ config, pkgs, vars, lib, ... }:

{
  # Add options for Wine
  options = {
    wine.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable Wine.
      '';
    };

    wine.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install Wine via home-manager or directly in the environment.
      '';
    };
  };

  # Install Wine if desired
  config = lib.mkIf config.wine.enable (lib.mkMerge [

    # Wine config for home-manager
    (lib.mkIf (config.wine.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Configure Wine packages
        home.packages = with pkgs; [
          wine
          winetricks
        ];
      };
    })

    # Wine config for environment
    (lib.mkIf (config.wine.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        wine
        winetricks
      ];
    })
  ]);
}

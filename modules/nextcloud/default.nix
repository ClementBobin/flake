{ config, lib, pkgs, vars, ... }:

{
  # Add options for nextcloud
  options = {
    nextcloud.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable Nextcloud.
      '';
    };

    nextcloud.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install Nextcloud via home-manager or directly in the environment.
      '';
    };
  };

  # Install Nextcloud if desired
  config = lib.mkIf config.nextcloud.enable (lib.mkMerge [

    # Nextcloud configuration for home-manager
    (lib.mkIf (config.nextcloud.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Configure Nextcloud
        home.packages = with pkgs; [
          nextcloud-client
        ];
      };
    })

    # Nextcloud configuration for system environment
    (lib.mkIf (config.nextcloud.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        nextcloud-client
      ];
    })

  ]);
}

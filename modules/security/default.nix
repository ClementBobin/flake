#
#  security
#

{ config, pkgs, vars, lib, ... }:

{
  # Add options for security
  options = {
    security.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable security tools and configurations.
      '';
    };

    security.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install security tools via home-manager or directly in the environment.
      '';
    };
  };

  # Configure security tools if desired
  config = lib.mkIf config.security.enable (lib.mkMerge [

    # Security tools configuration for home-manager
    (lib.mkIf (config.security.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Install security tools
        home.packages = with pkgs; [
          clamav
          stacer
        ];
      };
    })

    # Security tools configuration for system environment
    (lib.mkIf (config.security.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        clamav
        stacer
      ];
    })

  ]);
}

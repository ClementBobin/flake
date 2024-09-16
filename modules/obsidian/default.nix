#
#  obsidian
#

{ config, lib, pkgs, vars, ... }:

{
  # Add options for obsidian
  options = {
    obsidian.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable Obsidian.
      '';
    };

    obsidian.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install Obsidian via home-manager or directly in the environment.
      '';
    };
  };

  # Install Obsidian if desired
  config = lib.mkIf config.obsidian.enable (lib.mkMerge [

    # Obsidian configuration for home-manager
    (lib.mkIf (config.obsidian.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Configure Obsidian
        home.packages = with pkgs; [
          obsidian
        ];
      };
    })

    # Obsidian configuration for system environment
    (lib.mkIf (config.obsidian.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        obsidian
      ];
    })

  ]);
}

{ config, pkgs, vars, lib, ... }:

{
  # Add options for tailscale
  options = {
    tailscale.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable tailscale.
      '';
    };

    tailscale.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install tailscale via home-manager or directly in the environment.
      '';
    };
  };

  config = lib.mkIf config.tailscale.enable {

    # Install tailscale if desired
    home-manager.users.${vars.user} = {
      # Configure tailscale
      home.packages = with pkgs; [
        tailscale
      ];
    };


    # Configure tailscale service
    services.tailscale = {
      enable = true;
      # Additional service configuration can be added here
    };
  };
}

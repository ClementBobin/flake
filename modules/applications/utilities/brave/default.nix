#
#  brave
#

{ config, pkgs, vars, lib, ... }:

{
  # Add options for brave
  options = {
    brave.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable brave.
      '';
    }; 
  };

  # Install brave if desired
  config = lib.mkIf config.discord.enable {
    home-manager.users.${vars.user} = {
      # Configure brave
      home.packages = with pkgs; [
        brave
      ];
    };
  };
}

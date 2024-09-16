#
#  spotify
#

{ config, pkgs, vars, lib, ... }:

{
  # Add options for spotify
  options = {
    spotify.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable spotify.
      '';
    }; 
  };

  # Install spotify if desired
  config = lib.mkIf config.spotify.enable {
    home-manager.users.${vars.user} = {
      # Configure spotify
      home.packages = with pkgs; [

        # Enable spotify
        spotify
      ];
    };
  };
}

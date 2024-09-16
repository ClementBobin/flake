#
#  gimp
#

{ config, pkgs, vars, lib, ... }:

{
  # Add options for gimp
  options = {
    gimp.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable gimp.
      '';
    }; 
  };

  # Install gimp if desired
  config = lib.mkIf config.gimp.enable {
    home-manager.users.${vars.user} = {
      # Configure gimp
      home.packages = with pkgs; [

        # Enable gimp
        gimp
      ];
    };
  };
}

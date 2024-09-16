#
#  filezilla
#

{ config, pkgs, vars, lib, ... }:

{
  # Add options for filezilla
  options = {
    filezilla.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable filezilla.
      '';
    }; 
  };

  # Install filezilla if desired
  config = lib.mkIf config.filezilla.enable {
    home-manager.users.${vars.user} = {
      # Configure filezilla
      home.packages = with pkgs; [

        # Enable filezilla
        filezilla
      ];
    };
  };
}

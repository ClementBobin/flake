#
#  Parsec
#

{ config, pkgs, vars, lib, ... }:

{
  # Add options for parsec
  options = {
    parsec.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable parsec.
      '';
    }; 
  };

  # Install parsec if desired
  config = lib.mkIf config.parsec.enable {
    home-manager.users.${vars.user} = {
      # Configure parsec
      home.packages = with pkgs; [

        # Enable parsec
        parsec-bin
      ];
    };
  };
}

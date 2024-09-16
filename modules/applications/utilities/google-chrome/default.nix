#
#  google-chrome
#

{ config, pkgs, vars, lib, ... }:

{
  # Add options for google-chrome
  options = {
    google-chrome.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable google-chrome.
      '';
    }; 
  };

  # Install google-chrome if desired
  config = lib.mkIf config.google-chrome.enable {
    home-manager.users.${vars.user} = {
      # Configure google-chrome
      home.packages = with pkgs; [

        # Enable google-chrome
        google-chrome
      ];
    };
  };
}

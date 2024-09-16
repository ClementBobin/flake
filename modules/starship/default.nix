{ config, lib, pkgs, vars, ... }:

{
  # Add options for starship
  options = {
    starship.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable starship.
      '';
    }; 

    starship.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install starship via home-manager or directly in the environment.
      '';
    };
  };

  config = lib.mkIf config.starship.enable {
    # Install starship if desired
    home-manager.users.${vars.user} = {
      # Configure starship prompt for various shells
      programs.starship = {

        # Enable starship
        enable = true;
      };
    };
  };
}

{ config, lib, pkgs, vars, ... }:

{
  # Add options for swayidle
  options = {
    swayidle.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable swayidle.
      '';
    }; 
  };

  # Configure swayidle if desired
  config = lib.mkIf config.swayidle.enable {
    home-manager.users.${vars.user} = {
      # Configure swayidle
      services.swayidle = {

        # Install swayidle
        enable = true;

        # Configure commands to execute when timing out
        timeouts = [
          {
            timeout = 10;
            command = "notify-send 'LOCK'";
            resumeCommand = "notify-send 'Resume'";
          }
        ];
      };
    };
  };
}

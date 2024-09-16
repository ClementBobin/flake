{ config, lib, pkgs, vars, ... }:

{
  # Add options for btop system monitor
  options = {
    btop.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable btop system monitor.
      '';
    }; 
  };

  # Install btop if desired
  config = lib.mkIf config.btop.enable {
    home-manager.users.${vars.user} = {
      # Configure btop
      programs.btop = {

        # Enable btop
        enable = true;

        # Configuration for btop
        settings = {

          # Use default terminal background
          theme_background = false;

          # Use vim keys
          vim_keys = true;

          # Organise processes as a tree by default
          proc_tree = true;
        };
      };
    };
  };
}

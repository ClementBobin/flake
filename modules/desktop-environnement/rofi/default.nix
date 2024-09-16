{ config, lib, pkgs, vars, ... }:

{
  # Add options for rofi
  options = {
    rofi.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable rofi.
      '';
    }; 
  };

  # Install and configure rofi if desired
  config = lib.mkIf config.rofi.enable {
    home-manager.users.${vars.user} = {
      # Enable rofi
      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland-unwrapped;
      };

      # Set environment variables
      home.sessionVariables = {

        # Programs to use
        MENU_CMD = "~/.config/rofi/scripts/launch-rofi.sh";
        EXIT_CMD = "~/.config/wlogout/scripts/launch-wlogout.sh";
      };

      # Configure rofi
      xdg.configFile."rofi/config.rasi".text = builtins.readFile ./config.rasi;
      xdg.configFile."rofi/extra-config.rasi".text = '''';

      # Copy scripts folder
      xdg.configFile."rofi/scripts".source = ./scripts;
    };
  };
}

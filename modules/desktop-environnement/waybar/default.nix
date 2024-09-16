{ config, lib, pkgs, vars, ... }:

{
  # Add options for waybar
  options = {
    waybar.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable bwaybar.
      '';
    }; 
  };

  # Install waybar if desired
  config = lib.mkIf config.waybar.enable (lib.mkMerge [
    # General waybar settings
    {
      home-manager.users.${vars.user} = {
        # Enable waybar
        programs.waybar = {
          enable = true;
          style = ./style.css;
        };

        # Copy configurations
        xdg.configFile."waybar/configs".source = ./configs;
        xdg.configFile."waybar/modules.jsonc".source = ./modules.jsonc;
        xdg.configFile."waybar/extra-style.css".text = '''';

        # Copy scripts
        xdg.configFile."waybar/scripts".source = ./scripts;
        
        # Install extra programs for use with waybar
        home.packages = with pkgs; [

          # For controlling volume via pactl
          pulseaudio
        ];
      };
    }

    # Start waybar with hyprland
    (lib.mkIf config.hyprland.enable {
      home-manager.users.${vars.user} = {
        wayland.windowManager.hyprland.extraConfig = ''
          # Reload waybar
          exec = ~/.config/waybar/scripts/switch-waybar.sh
        '';
      };
    })
  ]);
}

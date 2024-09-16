{ config, lib, pkgs, vars, ... }:

{
  # Add options for kanshi
  options = {
    kanshi.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable kanshi
      '';
    }; 
  };

  # Enable kanshi if desired
  config = lib.mkIf config.kanshi.enable (lib.mkMerge [

    {
      home-manager.users.${vars.user} = {
        # Install kanshi as a package
        environment.systemPackages = with pkgs; [
          kanshi
        ];

        # Enable and configure kanshi
        services.kanshi = {
          enable = true;
          profiles = { };
        };
      };
    }

    #
    (lib.mkIf config.hyprland.enable {
      home-manager.users.${vars.user} = {
        wayland.windowManager.hyprland.extraConfig = ''
          # Reload kanshi
          exec = kanshi
        '';
      };
    })

  ]);
}

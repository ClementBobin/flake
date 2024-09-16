#Explanation:
#
#    options.dunst.installMethod: A new option to choose between home-manager or environment for installing and managing dunst.
#    Conditional Configuration:
#        If dunst.installMethod is "home-manager", it configures dunst via home-manager.
#        If dunst.installMethod is "environment", it configures dunst directly in the environment using systemd.
#
#Example Usage
#
#    Via Home-Manager:
#
#    nix
#
#{
#  dunst.enable = true;
#  dunst.installMethod = "home-manager";  # Manage dunst via home-manager
#}
#
#Via Environment:
#
#nix
#
#    {
#      dunst.enable = true;
#      dunst.installMethod = "environment";  # Manage dunst via system environment
#    }
#
#This approach provides the flexibility to choose the desired installation and management method for dunst, depending on the user's preference.

{ config, lib, pkgs, vars, ... }:

{
  # Add options for dunst
  options = {
    dunst.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to enable dunst.
      '';
    };
    dunst.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install dunst via home-manager or directly in the environment.
      '';
    };
  };

  # Install dunst if desired
  config = lib.mkIf config.dunst.enable (lib.mkMerge [

    # General dunst config for home-manager
    (lib.mkIf (config.dunst.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Enable dunst notification daemon
        services.dunst.enable = true;

        # Configure dunst
        xdg.configFile."dunst/dunstrc".source = ./dunstrc;

        # Copy scripts
        xdg.configFile."dunst/scripts".source = ./scripts;

        # Install dunst-specific packages
        home.packages = with pkgs; [

          # Mononoki font
          mononoki

          # Allows for xdg-open
          xdg-utils
        ];
      };
    })

    # General dunst config for environment
    (lib.mkIf (config.dunst.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        dunst
        mononoki
        xdg-utils
      ];

      environment.etc."xdg/dunst/dunstrc".source = ./dunstrc;
      environment.etc."xdg/dunst/scripts".source = ./scripts;

      systemd.user.services.dunst = {
        enable = true;
        description = "Dunst Notification Daemon";
        serviceConfig = {
          ExecStart = "${pkgs.dunst}/bin/dunst";
          Restart = "always";
        };
        wantedBy = [ "default.target" ];
      };
    })

    # Start dunst with hyprland
    (lib.mkIf config.hyprland.enable {
      home-manager.users.${vars.user} = {
        wayland.windowManager.hyprland.extraConfig = ''
          # Reload dunst
          exec = ~/.config/dunst/scripts/start-dunst.sh
        '';
      };
    })
  ]);
}

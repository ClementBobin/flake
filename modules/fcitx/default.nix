{ config, lib, pkgs, vars, ... }:

{
  # Add options for fcitx
  options = {
    fcitx.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable fcitx for input method management.
      '';
    };

    fcitx.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install and configure fcitx via home-manager or directly in the environment.
      '';
    };
  };

  # Install and configure fcitx if desired
  config = lib.mkIf config.fcitx.enable (lib.mkMerge [

    # Configure fcitx for home-manager
    (lib.mkIf (config.fcitx.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Configure fcitx5 input method
        i18n.inputMethod = {
          enabled = "fcitx5";
          fcitx5.addons = with pkgs; [
            fcitx5-mozc
            fcitx5-gtk
          ];
        };

        # Manage fcitx configuration
        xdg.configFile."fcitx5/config".source = ./config;

        # Set environment variables to use fcitx
        home.sessionVariables = {
          GTK_IM_MODULE = "fcitx";
          QT_IM_MODULE = "fcitx";
          XMODIFIERS = "@im=fcitx";
          SDL_IM_MODULE = "fcitx";
          #GLFW_IM_MODULE = "fcitx";
        };
      };
    })

    # Configure fcitx for environment
    (lib.mkIf (config.fcitx.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        fcitx5
        fcitx5-mozc
        fcitx5-gtk
      ];

      # Set environment variables for all users
      environment.variables = {
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
        SDL_IM_MODULE = "fcitx";
        GLFW_IM_MODULE = "fcitx";
      };
    })

    # Start fcitx on startup for Hyprland
    (lib.mkIf (config.hyprland.enable && config.fcitx.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        wayland.windowManager.hyprland.extraConfig = ''
          # Start fcitx5
          exec-once = fcitx5
        '';
      };
    })
  ]);
}

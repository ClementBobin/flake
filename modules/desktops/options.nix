#
#  Options to enable packages depending on the DE/WM. They options are enabled in the <desktop>.nix files.
#

{ lib, ... }:

with lib;
{
  options = {
    x11wm = {                   # Condition if host uses an X11 window manager
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    wlwm = {                    # Condition if host uses a wayland window manager
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    laptop = {                  # Condition if host is a laptop
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    btop = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    dunst = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    fcitx = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    firefox = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    gtk = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    kanshi = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    kitty = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };  
    };
    mako = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    mangohud = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    mpv = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    neovim = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    obs-studio = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    #qt = {
      #enable = mkOption {
        #type = types.bool;
        #default = false;
      #};
    #};
    rofi = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    starship = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    sway = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    sway-notification-center = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    swayidle = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    swaylock = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    themes = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    vs-code = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    waybar = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    wlogout = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    xdg = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    zsh = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
}

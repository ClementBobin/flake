#
#  Hyprland Configuration
#  Enable with "hyprland.enable = true;"
#

{ config, lib, system, pkgs, hyprland, vars, host, ... }:

let
  colors = import ../theming/colors.nix;
in
{
    options = {
      hyprland = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
      };
    };

    config = {
      programs = {
        xwayland.enable = true;
        neovim.enable = true;
        zsh.enable = true;
        hyprland.enable = true;
      };

      users.groups.hyprland.members = [ "${vars.user}" ];

      environment.systemPackages = with pkgs; [
        blueman
        brightnessctl
        dunst
        rofi
        swayidle
        wlogout
        grim
        slurp
        libsForQt5.polkit-kde-agent
        xdg-desktop-portal-gtk
        imagemagick
        pavucontrol
        pamixer
        libsForQt5.qtstyleplugin-kvantum
        libsForQt5.qt5ct
        kitty
        vim
        neofetch
        eza
        libsForQt5.qt5.qtimageformats
        libsForQt5.qt5.qtbase
        inih
        libsForQt5.ffmpegthumbs
        swaylock-effects
        swww
        hyprland-protocols
        sdbus-cpp
        wl-clipboard
        rustc
        pokemon-colorscripts-mac
        nwg-look
        cliphist
        wayland-protocols
        python311Packages.cmake
        jq
        pango
        ocamlPackages.cairo2
        python311Packages.meson
        python311Packages.xkbcommon
        mesa
        rPackages.gbm
        seatd
      ];
    };
  }

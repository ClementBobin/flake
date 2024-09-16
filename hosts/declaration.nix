#
#  Declaration Modules
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ declaration.nix
#   └─ ./modules
#       ├─ *
#       └─ ...
#
[
    ./globalOption.nix
    ../modules/applications/utilities/brave
    ../modules/applications/utilities/btop
    ../modules/applications/development/dbeaver
    ../modules/direnv
    ../modules/applications/communication/discord
    ../modules/applications/development/docker
    ../modules/dunst
    ../modules/environment/csharp.nix
    ../modules/environment/nodejs.nix
    ../modules/environment/php.nix
    ../modules/environment/python.nix
    ../modules/environment/wine.nix
    ../modules/fcitx
    ../modules/applications/utilities/filezilla
    ../modules/applications/utilities/firefox
    ../modules/flatpak
    ../modules/games
    ../modules/applications/multimedia/gimp
    ../modules/applications/development/git
    ../modules/applications/development/gitkraken
    ../modules/applications/utilities/google-chrome
    ../modules/gtk
    ../modules/desktop-environnement/hyprland
    ../modules/kanshi
    ../modules/kitty
    ../modules/mako
    #../modules/mangohud
    ../modules/applications/multimedia/mpv
    ../modules/neovim
    ../modules/nextcloud
    ../modules/applications/multimedia/obs-studio
    ../modules/obsidian
    ../modules/applications/multimedia/parsec
    ../modules/qt
    ../modules/desktop-environnement/rofi
    ../modules/security
    ../modules/applications/multimedia/spotify
    ../modules/starship
    ../modules/desktop-environnement/sway
    ../modules/desktop-environnement/sway-notification-center
    ../modules/desktop-environnement/swayidle
    ../modules/desktop-environnement/swaylock
    ../modules/tailscale
    ../modules/applications/communication/teams
    ../modules/themes
    #../modules/unity
    ../modules/applications/development/vs-code
    ../modules/desktop-environnement/waybar
    ../modules/desktop-environnement/wlogout
    ../modules/xdg
    ../modules/zsh
    





    # Other
    ../hardware/dslr.nix
    ../hardware/power.nix
    ../modules/services/avahi.nix
    ../modules/services/samba.nix
    ../modules/services/sxhkd.nix
    ../modules/services/udiskie.nix
    ../modules/services/redshift.nix
]
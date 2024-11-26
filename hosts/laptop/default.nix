{ config, pkgs, stable, lib, self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    <nixos-hardware/asus/fa507nv>
    #<nixos-hardware/common/gpu/amd>
    #../../hardware/asus/A15
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;

  home-manager.backupFileExtension = "hm-backup";
  networking.networkmanager.enable = true;

  services = {
    xserver = {
      videoDrivers = ["nvidia"];
      enable = true;
      #desktopManager.plasma5.enable = true;
      #windowManager.qtile.enable = true;
    };
    displayManager = {
      #sddm.enable = true;
      #sddm.wayland.enable = true;
    };
  };

  hardware.graphics = {
    enable = lib.mkDefault true;
    enable32Bit = lib.mkDefault true;
  };

  environment.systemPackages = with pkgs; [
    asusctl
    #bluemail
    #rnix-lsp

    # download youtube video
    #yt-dlp

    libglvnd
    libGL
    #clinfo  # Optional, to verify OpenCL setup
    #libEGL
    #supergfxctl
    #gnomeExtensions.battery-threshold
    #gnomeExtensions.battery-health-charging

    (pkgs.writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$0"
    '')
  ] ++ (with stable; [
    # Fuzzy file finding
    fzf

    # Cheat sheets
    navi
    tmux
    #lshw
    home-manager
    fastfetch

    jetbrains.rider
    jetbrains.datagrip
    jetbrains.phpstorm
    jetbrains.webstorm
    jetbrains.gateway
    jetbrains-toolbox

    chromedriver

    #virtualbox
    #flatpak
  ]);

  hardware.nvidia = {
    modesetting.enable = true;
  };

  # head /sys/class/drm/*/status
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nomodeset"
    "usbcore.autosuspend=-1"
    "video=efifb:off"
    "video=HDMI-A-1:1920x1080@60"
  ];

  # hardware.enableAllFirmware = true;

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      #platformOptimizations.enable = true;
    };
    gamemode.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  hardware.nvidia.open = false;

  services.asusd.enable = true;

  ##################
  # Custom modules #
  ##################

  laptop.enable = true;
  x11wm.enable = true;
  themes.enable = true;

  #brave.enable = true;
  btop.enable = true;
  dbeaver.enable = true;
  discord.enable = true;
  docker.enable = true;
  dunst.enable = true;

  # Environment
  csharp.enable = true;
  nodejs.enable = true;
  php.enable = true;
  #python.enable = true;
  wine.enable = true;


  fcitx.enable = true;
  #filezilla.enable = true;
  firefox.enable = true;
  game.enable = true;
  gimp.enable = true;
  git.enable = true;
  #gitkraken.enable = true;
  google-chrome.enable = true;
  gtk.enable = true;
  hyprland.enable = true;
  kitty.enable = true;
  mangohud.enable = true;
  #mpv.enable = true;
  #neovim.enable = true;
  #nextcloud.enable = true;
  obs-studio.enable = true;
  openshot.enable = true;
  obsidian.enable = true;
  #parsec.enable = true;
  qt.config.enable = true;
  rofi.enable = true;
  security.enable = true;
  spotify.enable = true;
  starship.enable = true;
  tailscale.enable = true;
  teams-for-linux.enable = true;
  #unity.enable = false;
  vs-code.enable = true;
  waybar.enable = true;
  wlogout.enable = true;
  xdg.config.enable = true;
  zsh.enable = true;
}

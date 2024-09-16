{ config, pkgs, lib, stable, self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    #<nixos-hardware/asus/fa507nv>
    ../../hardware/asus/A15
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  networking.networkmanager.enable = true;

  services = {
    xserver = {
      videoDrivers = ["amdgpu" "nvidia"];
      enable = true;
      desktopManager.plasma6.enable = true;
      windowManager.qtile.enable = true;
    };
    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
    };
  };

  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [    
    asusctl
    bluemail
  ] ++ (with stable; [
    #rnix-lsp
    unityhub

    # download youtube video
    youtube-dl

    # Fuzzy file finding
    fzf

    # Cheat sheets
    navi

    libglvnd
    libGL
    #libEGL
    #libEGLnvidia-settings

    (pkgs.writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$0"
    '')
  ]);

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
      vaapiVdpau 
      nvidia-vaapi-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
 
  # hint electron apps to use wayland
  #environment.sessionVariables = {
    #NIXOS_OZONE_WL = "1";
  #};
 
  # screen sharing
  #services.dbus.enable = true;
  #xdg.portal = {
    #enable = true;
    #wlr.enable = true;
    #extraPortals = [
      #pkgs.xdg-desktop-portal-gtk
    #];
  #};

  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  ##################
  # Custom modules #
  ##################

  laptop.enable = true;
  #x11wm.enable = true;
  #themes.enable = true;

  brave.enable = true;
  btop.enable = true;
  dbeaver.enable = true;
  discord.enable = true;
  docker.enable = true;
  dunst.enable = true;

  # Environment
  csharp.enable = true;
  nodejs.enable = true;
  php.enable = true;
  python.enable = true;
  wine.enable = true; 


  fcitx.enable = true;
  filezilla.enable = true;
  firefox.enable = true;
  game.enable = true;
  gimp.enable = true;
  git.enable = true;
  gitkraken.enable = true;
  google-chrome.enable = true;
  #gtk.enable = true;
  #hyprland.enable = true;
  kitty.enable = true;
  #mangohud.enable = true;
  mpv.enable = true;
  #neovim.enable = true;
  nextcloud.enable = true;
  obs-studio.enable = true;
  openshot.enable = true;
  obsidian.enable = true;
  parsec.enable = true;
  #qt.config.enable = true;
  #rofi.enable = true;
  security.enable = true;
  spotify.enable = true;
  starship.enable = true;
  tailscale.enable = true;
  teams-for-linux.enable = true;
  #unity.enable = true; # failed
  vs-code.enable = true;
  #waybar.enable = true;
  #wlogout.enable = true;
  #xdg.config.enable = true;
  zsh.enable = true; 
}

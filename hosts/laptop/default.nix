{ config, pkgs, libs, stable, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/virtualisation/docker.nix
    ../../modules/desktops/virtualisation/virtualbox.nix
    ../../modules/engine/unity.nix
    # Remove or correct the following line if `noboot.nix` is not needed or is located elsewhere
    #../../modules/common/noboot.nix
    <nixos-hardware/asus/fa507nv>
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  networking.networkmanager.enable = true;

  laptop.enable = true;
  #hyprland.enable = true;

  services.xserver = {
    videoDrivers = ["nvidia"];
    enable = true;
    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
    };
    desktopManager.plasma5.enable = true;
    windowManager.qtile.enable = true;
  };

  environment.systemPackages = with pkgs; [
    simple-scan
    onlyoffice-bin
    obs-studio
    openshot-qt
    wireshark
    dbeaver
    openssl_3_1
    corepack_21
    asusctl
    wayland-utils
    bluemail
    clamav
    stacer
    vesktop
    xwayland
    qbittorrent
  ] ++ (with stable; [
    brave
    firefox
    discord
    gimp
    python311Full
    python311Packages.pip
    python311Packages.numpy
    php83Packages.composer
    php83
    google-chrome
    mpc_cli
    playerctl
    rnix-lsp
    slurp
    vulkan-tools
    wdisplays
    wl-clipboard
    youtube-dl
  ]);

  flatpak.extraPackages = [
    "com.github.tchx84.Flatseal"
  ];

  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  programs.wireshark.enable = true;

  ##################
  # Custom modules #
  ##################

  themes.enable = true;
  btop.enable = true;
  dunst.enable = true;
  fcitx.enable = true;
  firefox.enable = true;
  gtk.config.enable = true;
  hyprland.enable = true;
  kitty.enable = true;
  mangohud.enable = true;
  mpv.enable = true;
  neovim.enable = true;
  obs-studio.enable = true;
  qt.config.enable = true;
  rofi.enable = true;
  starship.enable = true;
  vs-code.enable = true;
  waybar.enable = true;
  wlogout.enable = true;
  xdg.config.enable = true;
  zsh.enable = true;

  # Configure user experience
  home = {

    # Home variables
    stateVersion = "22.11";

    # Set environment variables
    sessionVariables = {

      # Programs to use
      MENU_CMD = "~/.config/rofi/scripts/launch-rofi.sh";
      EXIT_CMD = "~/.config/wlogout/scripts/launch-wlogout.sh";
    };
  };

  programs = {

    # Fuzzy file finding
    fzf.enable = true;

    # Cheat sheets
    navi.enable = true;
  };
}

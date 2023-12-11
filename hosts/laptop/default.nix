#
#  Specific system configuration settings for laptop
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ ./laptop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       ├─ ./engine
#       |   └─ ./unity.nix
#       └─ ./desktops
#           ├─ bspwm.nix
#           └─ ./virtualisation
#

{ pkgs, stable, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/virtualisation/docker.nix   # Docker/Virtualbox
    ../../modules/desktops/virtualisation/virtualbox.nix
    ../../modules/engine/unity.nix
  ];

  boot = {                                  # Boot Options
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
        grub = {
            enable = true;
            useOSProber = true;
            configurationLimit = 15;
            device = "/dev/sda";
            #efiSupport = true;
            #enableCryptodisk = true;
        };
        timeout = 15;
    };
    #initrd.luks.devices = {                 # crypt disk
        #root = {
            #device = "/dev/disk/by-label/nixos";
            #preLVM = true;
        #};
    #};
  };

  hardware.sane = {                         # Scanning
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  networking.networkmanager.enable = true; # network

  laptop.enable = true;                       # Laptop Modules
  #hyprland.enable = true;                     # Window Manager
  services.xserver = {                        # graphique
    enable = true;
    displayManager = {
      sddm.enable = true;
    };
    desktopManager.plasma5.enable = true;
    windowManager.qtile.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [           # System-Wide Packages
      simple-scan       # Scanning
      onlyoffice-bin    # Office
    ] ++
    (with stable; [
      brave             # Browser
      firefox           # Browser
      discord           # Communication
      gimp              # Image editor
    ]);
  };

  flatpak = {                               # Flatpak Packages (see module options)
    extraPackages = [
      "com.github.tchx84.Flatseal"
    ];
  };
}

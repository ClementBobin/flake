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
#       └─ ./desktops
#           ├─ bspwm.nix
#           └─ ./virtualisation
#               └─ docker.nix
#

{ pkgs, stable, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/virtualisation/docker.nix
  ];

  boot = {                                  # Boot Options
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
        grub = {
            enable = true;
            useOSProber = true;
            configurationLimit = 5;
            device = "/dev/sda";
            #efiSupport = true;
            #enableCryptodisk = true;
        };
        timeout = 15;
    };
    #initrd.luks.devices = {
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

  networking.networkmanager.enable = true;

  # laptop.enable = true;                     # Laptop Modules
  # services.xserver.windowManager.bspwm.enable = true;                      # Window Manager
  services.xserver = {
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
      brave
      discord
    ]);
  };

  flatpak = {                               # Flatpak Packages (see module options)
    extraPackages = [
      "com.github.tchx84.Flatseal"
    ];
  };
}

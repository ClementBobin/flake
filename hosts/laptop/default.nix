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

{ pkgs, vars, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/virtualisation/docker.nix
  ];

  boot = {
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

  laptop.enable = true;                     # Laptop Modules
  bspwm.enable = true;                      # Window Manager

  environment = {
    systemPackages = with pkgs; [           # System-Wide Packages
      simple-scan       # Scanning
      onlyoffice-bin    # Office
    ];
  };

  programs.light.enable = true;             # Monitor Brightness

  services = {
    printing = {                            # Printing
      enable = true;
    };
  };

  flatpak = {                               # Flatpak Packages (see module options)
    extraPackages = [
      "com.github.tchx84.Flatseal"
    ];
  };

  systemd.tmpfiles.rules = [                # Temporary Bluetooth Fix
    "d /var/lib/bluetooth 700 root root - -"
  ];
  systemd.targets."bluetooth".after = ["systemd-tmpfiles-setup.service"];
}

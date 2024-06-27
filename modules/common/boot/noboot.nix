{
  ####################
  # Boot Options     #
  ####################
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {                                  # Grub Dual Boot
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;                     # Find All boot Options
        configurationLimit = 5;
        default=2;
      };
      timeout = 15;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
}

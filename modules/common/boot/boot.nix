{
  ####################
  # Boot Options     #
  ####################
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
      };
      timeout = 1;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
}

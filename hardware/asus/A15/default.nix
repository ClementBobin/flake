{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../common/cpu/amd
    ../../common/cpu/amd/raphael/igpu.nix
    ../../common/cpu/amd/pstate.nix
    ../../common/gpu/nvidia
    ../../common/gpu/nvidia/prime.nix
    ../../common/hidpi.nix
    ../../common/pc/laptop
    ../../common/pc/ssd
    ../../common/battery.nix
  ];

  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.6") pkgs.linuxPackages_latest;

  # The bottom 2 parts are taken from the framework 16-inch laptops configurations.
  # Workaround for SuspendThenHibernate: https://lore.kernel.org/linux-kernel/20231106162310.85711-1-mario.limonciello@amd.com/
  boot.kernelParams = lib.optionals (lib.versionOlder config.boot.kernelPackages.kernel.version "6.8") ["rtc_cmos.use_acpi_alarm=1"];


  # Adds the missing asus functionality to Linux.
  # https://asus-linux.org/manual/asusctl-manual/
  services = {
    asusd = {
      enable = lib.mkDefault true;
      enableUserService = lib.mkDefault true;
    };
  };


  # AMD has better battery life with PPD over TLP:
  # https://community.frame.work/t/responded-amd-7040-sleep-states/38101/13
  services.power-profiles-daemon.enable = lib.mkDefault true;

    hardware.nvidia = {
    # Modesetting.
    modesetting.enable = lib.mkDefault false;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = lib.mkDefault false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = lib.mkDefault true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = lib.mkDefault false;

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = lib.mkDefault true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.stable;
    
    prime = {
      sync.enable = lib.mkDefault false;
      offload.enable = lib.mkDefault true;
      nvidiaBusId = lib.mkDefault "PCI:1:0:0"; # Use lspci to find your NVIDIA GPU bus ID
      amdgpuBusId = lib.mkDefault "PCI:35:00:0";  # Use lspci to find your AMD GPU bus ID
    };
  };

}
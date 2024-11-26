#
#  Main system configuration.
##############################
#  flake.nix                 #
#   ├─ ./hosts               #
#   │   ├─ default.nix       #
#   │   └─ configuration.nix #
#   └─ ./modules             #
#       ├─ ./desktops        #
#       │   └─ default.nix   #
#       ├─ ./editors         #
#       │   └─ default.nix   #
#       ├─ ./hardware        #
#       │   └─ default.nix   #
#       ├─ ./programs        #
#       │   └─ default.nix   #
#       ├─ ./services        #
#       │   └─ default.nix   #
#       ├─ ./shell           #
#       │   └─ default.nix   #
#       └─ ./theming         #
#           └─ default.nix   #
##############################

{ config, lib, pkgs, stable, inputs, vars, ... }:

{
  imports = ( import ./declaration.nix );

  ####################
  # System User      #
  ####################
  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" "libvirtd" ];
  };

  ####################
  # Time and Locale  #
  ####################
  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  console = {
    keyMap = "fr";
  };

  ####################
  # X Server         #
  ####################
  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };

  ####################
  # Security         #
  ####################
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  ####################
  # Hardware         #
  ####################
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  hardware.pulseaudio.enable = false;

  ####################
  # Environment      #
  ####################
  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      git         # Version Control
      killall     # Process Killer
      nix-tree    # Browse Nix Store
      tree       # View tree

      alsa-utils # Audio Control
      pavucontrol# Audio Control
      pipewire   # Audio Server/Control
      #pulseaudio # Audio Server/Control
      stremio    # Media Streamer

      okular     # PDF Viewer
      p7zip      # Zip Encryption
      unzip      # Zip Files
      unrar      # Rar Files
      #zip        # Zip

      nmap       # Network discovery and security auditing
      #yed        # Diagrams

      #kate       # Editor KDE
      #neofetch

      simple-scan
      onlyoffice-bin

      #openssl_3_3
    ] ++
    (with stable; [
      # Apps
    ]);
  };

  ####################
  # Firewall         #
  ####################
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
    interfaces."eth0".allowedTCPPorts = [ 80 443 ];
  };

  ####################
  # System Services  #
  ####################
  services = {
    printing = {                            # CUPS
      enable = true;
      drivers = [ pkgs.cnijfilter2 ];
    };
    pipewire = {                            # Sound
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      audio.enable = true;
      wireplumber.enable = true;
    };
    openssh = {                             # SSH
      enable = true;
      allowSFTP = true;                     # SFTP
      extraConfig = ''
        HostKeyAlgorithms +ssh-rsa
      '';
    };
  };

  ####################
  # Flatpak          #
  ####################
  flatpak = {
    enable = true;
    extraPackages = [
      "com.github.tchx84.Flatseal"
    ];
  };

  ####################
  # Nix Settings     #
  ####################
  nix = {
    settings ={
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;

  ####################
  # NixOS Settings   #
  ####################
  system = {
    stateVersion = "24.11";
  };

  ####################
  # Home-Manager     #
  ####################
  home-manager.users.${vars.user} = {
    home = {
      stateVersion = "24.11";
    };

    programs = {
      home-manager.enable = true;
    };
  };
}

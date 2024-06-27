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
  imports = ( import ../modules/desktops ++
              import ../modules/editors ++
              import ../modules/hardware ++
              import ../modules/programs ++
              import ../modules/services ++
              import ../modules/shell ++ 
              import ../modules/theming );

  ####################
  # System User      #
  ####################
  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" "libvirtd" "plex" "vboxusers" "wireshark" ];
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
  services.xserver = {
    layout = "fr";
    xkbVariant = "azerty";
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
      git        # Version Control
      killall    # Process Killer
      nano       # Text Editor
      nix-tree   # Browse Nix Store
      wget       # Retriever
      tree       # View tree 
      
      alsa-utils # Audio Control
      feh        # Image Viewer
      mpv        # Media Player
      pavucontrol# Audio Control
      pipewire   # Audio Server/Control
      pulseaudio # Audio Server/Control
      vlc        # Media Player
      stremio    # Media Streamer
		
      okular     # PDF Viewer
      p7zip      # Zip Encryption
      unzip      # Zip Files
      unrar      # Rar Files
      zip        # Zip

      nmap       # Network discovery and security auditing
      yed        # Diagrams

      kate       # Editor KDE
      clamav
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
      #lowLatency = {
        # enable this module
        #enable = true;
        # defaults (no need to be set unless modified)
        #quantum = 64;
        #rate = 48000;
      #};
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
  flatpak.enable = true;

  ####################
  # Nix Settings     #
  ####################
  nix = {
    settings ={
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.unstable;
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
    stateVersion = "23.11";
  };

  ####################
  # Home-Manager     #
  ####################
  home-manager.users.${vars.user} = {
    home = {
      stateVersion = "23.11";
    };

    programs = {
      home-manager.enable = true;
    };
  };
}

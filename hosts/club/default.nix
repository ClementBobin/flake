  # Specific system configuration settings for club

  ##########################################
  # flake.nix                              #
  # ├─ ./hosts                             #
  # │   ├─ default.nix                     #
  # │   └─ ./club                          #
  # │        ├─ default.nix                #
  # │        └─ hardware-configuration.nix #
  ##########################################

{ config, lib, pkgs, stable, inputs, vars, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  ####################
  # System           #
  ####################
  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" "libvirtd" "plex" ];
  };

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

  #####################
  # Security Settings #
  #####################
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  ####################
  # Boot Options     #
  ####################
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
        grub = {
            enable = true;
            useOSProber = true;
            configurationLimit = 5;
            device = "/dev/sda";
        };
        timeout = 15;
    };
  };

  ####################
  # Scanning         #
  ####################
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  ####################
  # Network          #
  ####################
  networking.networkmanager.enable = true;

  #######################
  # Graphical Interface #
  #######################
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
    };
    desktopManager.plasma5.enable = true;
    windowManager.qtile.enable = true;
  };

  #########################
  # Environment Variables #
  #########################
  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      # Terminal
      git # Version Control
      killall # Process Killer
      nano # Text Editor
      nix-tree # Browse Nix Store
      wget # Retriever
      tree # View tree

      # Video/Audio
      alsa-utils # Audio Control
      feh # Image Viewer
      mpv # Media Player
      pavucontrol # Audio Control
      pipewire # Audio Server/Control
      pulseaudio # Audio Server/Control
      vlc # Media Player
      stremio # Media Streamer

      # File Management
      okular # PDF Viewer
      p7zip # Zip Encryption
      unzip # Zip Files
      unrar # Rar Files
      zip # Zip

      nmap # Network discovery and security auditing
      yed # Diagrams

      kate # Editor KDE
      simple-scan # Scanning
      onlyoffice-bin # Office
      docker
      vscode

      # Windows compatibility
      wine            # Wine
      winetrick

      # Teams
      teams-for-linux
    ] ++
    (with stable; [
        brave
    ]);
  };

  ####################
  # System Services  #
  ####################
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.cnijfilter2 ];
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {
      enable = true;
      allowSFTP = true;
      extraConfig = ''
        HostKeyAlgorithms +ssh-rsa
      '';
    };
  };

  ################
  # Nix Settings #
  ################
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

  #########################
  # Home-Manager Settings #
  #########################
  home-manager.users.${vars.user} = {
    home = {
      stateVersion = "23.11";
    };

    programs = {
      home-manager.enable = true;
    };
  };
}

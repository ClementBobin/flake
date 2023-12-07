#
#  Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ configuration.nix *
#   └─ ./modules
#       ├─ ./desktops
#       │   └─ default.nix
#       ├─ ./editors
#       │   └─ default.nix
#       ├─ ./hardware
#       │   └─ default.nix
#       ├─ ./programs
#       │   └─ default.nix
#       ├─ ./services
#       │   └─ default.nix
#       ├─ ./shell
#       │   └─ default.nix
#       └─ ./theming
#           └─ default.nix
#

{ config, lib, pkgs, stable, inputs, vars, ... }:

{
  imports = ( import ../modules/desktops ++
              import ../modules/editors ++
              import ../modules/hardware ++
              import ../modules/programs ++
              import ../modules/services ++
              import ../modules/shell ++ 
              import ../modules/theming );

  users.users.${vars.user} = {              # System User
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" "libvirtd" "plex" ];
  };

  time.timeZone = "Europe/Paris";        # Time zone and Internationalisation
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

  services.xserver = {
    layout = "fr";
    xkbVariant = "azerty";
    xkbOptions = "eurosign:e";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

    hardware.bluetooth = {
        enable = true;
        #hsphfpd.enable = true; # HSP  HFS daemon
        settings = {
                General = {
                        Enable = "Source,Sink,Media,Socket";
                };
 
        };
  };

  environment = {
    variables = {                           # Environment Variables
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [           # System-Wide Packages
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

		# Other Packages Found @
		# - ./<host>/default.nix
		# - ../modules
    ] ++
    (with stable; [
      # Apps
    ]);
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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
    };
    openssh = {                             # SSH
      enable = true;
      allowSFTP = true;                     # SFTP
      extraConfig = ''
        HostKeyAlgorithms +ssh-rsa
      '';
    };
  };

  #xdg.portal.enable = true;
  #services.flatpak.enable = true;                    # Enable Flatpak (see module options)

  nix = {                                   # Nix Package Manager Settings
    settings ={
      auto-optimise-store = true;
    };
    gc = {                                  # Garbage Collection
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.unstable;    # Enable Flakes
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;        # Allow Proprietary Software.

  system = {                                # NixOS Settings
    #autoUpgrade = {                        # Allow Auto Update (not useful in flakes)
    #  enable = true;
    #  channel = "https://nixos.org/channels/nixos-unstable";
    #};
    stateVersion = "23.11";
  };

  home-manager.users.${vars.user} = {       # Home-Manager Settings
    home = {
      stateVersion = "23.11";
    };

    programs = {
      home-manager.enable = true;
    };
  };
}

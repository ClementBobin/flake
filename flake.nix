#
#  flake.nix *
#   ├─ ./hosts
#   │   └─ default.nix
#   ├─ ./darwin
#   │   └─ default.nix
#   └─ ./nix
#       └─ default.nix
#

{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs =                                                                  # References Used by Flake
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";                  # Unstable Nix Packages (Default)
      nixpkgs-stable.url = "github:nixos/nixpkgs/release-23.11";            # Stable Nix Packages

      home-manager = {                                                      # User Environment Manager
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      darwin = {                                                            # MacOS Package Management
        url = "github:lnl7/nix-darwin/master";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {                                                               # NUR Community Packages
        url = "github:nix-community/NUR";                                   # Requires "nur.nixosModules.nur" to be added to the host modules
      };

      nixgl = {                                                             # Fixes OpenGL With Other Distros.
        url = "github:guibou/nixGL";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      emacs-overlay = {                                                     # Emacs Overlays
        url = "github:nix-community/emacs-overlay";
        flake = false;
      };

      doom-emacs = {                                                        # Nix-Community Doom Emacs
        url = "github:nix-community/nix-doom-emacs";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.emacs-overlay.follows = "emacs-overlay";
      };

      hyprland = {                                                          # Official Hyprland Flake
        url = "github:hyprwm/Hyprland";                                     # Requires "hyprland.nixosModules.default" to be added the host modules
        inputs.nixpkgs.follows = "nixpkgs";
      };

      plasma-manager = {                                                    # KDE Plasma User Settings Generator
        url = "github:pjones/plasma-manager";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-stable, home-manager, darwin, nur, nixgl, doom-emacs, hyprland, plasma-manager, ... }:   # Function telling flake which inputs to use
    let
      vars = {                                                              # Variables Used In Flake
        user = "mirage";
        location = "$HOME/.setup";
        terminal = "alacritty";
        editor = "nano";
      };
    in
    {
      nixosConfigurations = (                                               # NixOS Configurations
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable home-manager nur doom-emacs hyprland plasma-manager vars;   # Inherit inputs
        }
      );

      darwinConfigurations = (                                              # Darwin Configurations
        import ./darwin {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable home-manager darwin vars;
        }
      );

      homeConfigurations = (                                                # Nix Configurations
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable home-manager nixgl vars;
        }
      );
    };
}
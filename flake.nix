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
  description = "Nix, NixOS and Nix System Flake Configuration";

  inputs =                                                                  # References Used by Flake
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";                     # Stable Nix Packages (Default)
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Unstable Nix Packages

      home-manager = {                                                      # User Environment Manager
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {                                                               # NUR Community Packages
        url = "github:nix-community/NUR";                                   # Requires "nur.nixosModules.nur" to be added to the host modules
      };

      hyprland = {                                                          # Official Hyprland Flake
        url = "github:hyprwm/Hyprland";                                     # Requires "hyprland.nixosModules.default" to be added the host modules
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

      plasma-manager = {                                                    # KDE Plasma User Settings Generator
        url = "github:pjones/plasma-manager";                               # Requires "inputs.plasma-manager.homeManagerModules.plasma-manager" to be added to the home-manager.users.${user}.imports
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, nur, hyprland, plasma-manager, ... }:   # Function telling flake which inputs to use
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
          inherit inputs nixpkgs nixpkgs-unstable home-manager hyprland nur plasma-manager vars;   # Inherit inputs
        }
      );

      homeConfigurations = (                                                # Nix Configurations
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager vars;
        }
      );
    };
}
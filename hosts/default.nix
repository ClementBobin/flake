{ lib, inputs, nixpkgs, nixpkgs-stable, home-manager, nur, doom-emacs, hyprland, plasma-manager, vars, ... }:

let
  system = "x86_64-linux";                                  # System Architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow Proprietary Software
  };

  stable = import nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  #################################
  # Laptop Profile                #
  #################################
  laptop = lib.nixosSystem {                                
    inherit system;
    specialArgs = {
      inherit inputs stable vars;
      host = {
        hostName = "laptop";
      };
    };
    modules = [
      ./laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}

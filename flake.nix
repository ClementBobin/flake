{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; 
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.05";
    nix-gaming.url = "github:fufexan/nix-gaming";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      flake = false;
    };

    doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.emacs-overlay.follows = "emacs-overlay";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-stable, home-manager, darwin, nur, nixgl, doom-emacs, hyprland, plasma-manager, nix-gaming, ... }:
  let
    vars = {
      user = "mirage";
      location = "$HOME/.setup";
      terminal = "alacritty";
      editor = "nano";
    };
  in {
    nixosConfigurations = import ./hosts {
      inherit (nixpkgs) lib pkgs;
      inherit inputs nixpkgs nixpkgs-stable home-manager nur doom-emacs hyprland plasma-manager nix-gaming vars;
    };
  };
}

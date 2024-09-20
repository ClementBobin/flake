#
#  Gaming: Steam + MC + Emulation
#  Do not forget to enable Steam play for all title in the settings menu
#

{ config, pkgs, nur, lib, stable, inputs, vars, ... }:

{
  # Add options for gaming
  options = {
    game.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable gaming setup including Steam, Lutris, Heroic, and other tools.
      '';
    };

    game.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install gaming tools via home-manager or directly in the environment.
      '';
    };
  };

  # Install gaming tools if desired
  config = lib.mkIf config.game.enable (lib.mkMerge [

    # Gaming tools configuration for home-manager
    (lib.mkIf (config.game.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Optional: Enable force feedback for game controllers
        # hardware.new-lg4ff.enable = true;

        home.packages = with pkgs; [
          heroic         # Game Launcher
          lutris         # Game Launcher
          steam          # Game Launcher
          stable.playonlinux # break (unstable) cause wxpy-4.2.1 not suported for py3.12
          protonup-qt
          protontricks
          stable.prismlauncher
          inputs.nix-gaming.packages.${pkgs.system}.star-citizen
          vulkan-tools
          # Uncomment as needed:
          # inputs.nix-gaming.packages.${pkgs.system}.northstar-proton
          # inputs.nix-gaming.packages.${pkgs.system}.viper
          # inputs.nix-gaming.packages.${pkgs.system}.roblox-player
          # inputs.nix-gaming.packages.${pkgs.system}.rocket-league
        ];

        # # Steam configuration
        # programs.steam = {
        #   enable = true;
        #   remotePlay.openFirewall = true;
        #   # Uncomment to enable platform optimizations
        #   platformOptimizations.enable = true;
        #   dedicatedServer.openFirewall = true;
        # };

        # GameMode for better performance
        #programs.gamemode.enable = true;          # Better Gaming Performance
                                                  # Steam: Right-click game - Properties - Launch options: gamemoderun %command%
                                                  # Lutris: General Preferences - Enable Feral GameMode
                                                  #       
        
        # Environment variables for GameMode
        home.sessionVariables = {
          LD_PRELOAD = "${pkgs.gamemode}/lib/libgamemodeauto.so";
        };
      };
    })

    # Gaming tools configuration for environment
    (lib.mkIf (config.game.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        stable.heroic
        stable.lutris
        stable.steam
        (steam.override { usePrimus = true; })
        stable.playonlinux
        stable.protonup-qt
        stable.protontricks
        stable.prismlauncher
        inputs.nix-gaming.packages.${pkgs.system}.star-citizen
        stable.vulkan-tools
        # Uncomment as needed:
        # inputs.nix-gaming.packages.${pkgs.system}.northstar-proton
        # inputs.nix-gaming.packages.${pkgs.system}.viper
        # inputs.nix-gaming.packages.${pkgs.system}.roblox-player
        # inputs.nix-gaming.packages.${pkgs.system}.rocket-league
      ];


      programs = {
        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          #platformOptimizations.enable = true;
        };
        gamemode.enable = true; 
      };

      # Ensure Steam and other unfree packages are allowed
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-runtime"
      ]; 
    })

    # Allow unfree packages for Steam
    #nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    #  "steam"
    #  "steam-original"
    #  "steam-runtime"
    #];
  ]);
}

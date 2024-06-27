#
#  Gaming: Steam + MC + Emulation
#  Do not forget to enable Steam play for all title in the settings menu
#

{ config, pkgs, nur, lib, stable, inputs, ... }:

{
  #hardware.new-lg4ff.enable = true;            # Force Feedback

  environment.systemPackages = [
    stable.heroic         # Game Launcher
    stable.lutris         # Game Launcher
    stable.steam          # Game Launcher
    stable.playonlinux
    stable.protonup-qt
    stable.protontricks
    stable.prismlauncher
    inputs.nix-gaming.packages.${pkgs.system}.star-citizen
    #inputs.nix-gaming.packages.${pkgs.system}.northstar-proton
    #inputs.nix-gaming.packages.${pkgs.system}.viper
    #inputs.nix-gaming.packages.${pkgs.system}.roblox-player
    #inputs.nix-gaming.packages.${pkgs.system}.rocket-league
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      #platformOptimizations.enable = true;
    };
    gamemode.enable = true;                     # Better Gaming Performance
                                                # Steam: Right-click game - Properties - Launch options: gamemoderun %command%
                                                # Lutris: General Preferences - Enable Feral GameMode
                                                #                             - Global options - Add Environment Variables: LD_PRELOAD=/nix/store/*-gamemode-*-lib/lib/libgamemodeauto.so
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];                                            # Steam for Linux Libraries
}

#
#  Gaming: Steam + MC + Emulation
#  Do not forget to enable Steam play for all title in the settings menu
#

{ config, pkgs, nur, lib, stable, ... }:

let
  pcsx2 = pkgs.pcsx2.overrideAttrs (old: {      # PCSX2 Wrapper to run under X11
    nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.makeWrapper ];
    postFixup = ''
      wrapProgram $out/bin/pcsx2 \
        --set GDK_BACKEND x11
    '';
  });
in
{
  #hardware.new-lg4ff.enable = true;            # Force Feedback

  environment.systemPackages = [
    #config.nur.repos.c0deaddict.oversteer      # Steering Wheel Configuration
    stable.heroic         # Game Launcher
    stable.lutris         # Game Launcher
    stable.prismlauncher  # MC Launcher
    pkgs.retroarchFull      # Emulator
    stable.steam          # Game Launcher
    pkgs.pcsx2                   # Emulator
    stable.playonlinux
    stable.protonup-qt
    stable.protontricks
    stable.minecraft
  ];

  programs = {
    steam = {
      enable = true;
      #remotePlay.openFirewall = true;
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

{ config, pkgs, vars, lib, ... }:

{
  # Add options for git
  options = {
    git.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable git.
      '';
    };

    git.installMethod = lib.mkOption {
      type = lib.types.str;
      default = "home-manager";
      description = ''
        Specify the installation method: "home-manager" or "environment".
      '';
    };
  };

  # Configuration based on install method
  config = lib.mkIf config.git.enable {
    home-manager.users.${vars.user} = {
      # Configure git via Home Manager
      programs.git = {
        enable = true;
      };
    };
  };
}

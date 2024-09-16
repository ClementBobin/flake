{ config, pkgs, vars, lib, ... }:

{
  # Add options for gitkraken
  options = {
    gitkraken.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable gitkraken.
      '';
    };

    gitkraken.installMethod = lib.mkOption {
      type = lib.types.str;
      default = "home-manager";
      description = ''
        Specify the installation method: "home-manager" or "environment".
      '';
    };
  };

  # Install gitkraken if desired
  config = lib.mkIf config.gitkraken.enable {
    home-manager.users.${vars.user} = {
      # Configure gitkraken via Home Manager
      home.packages = with pkgs; [
        gitkraken
      ];
    };
  };
}

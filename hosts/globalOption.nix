{ config, vars, lib, ... }:

{
  # Add global options
  options = {
    globalInstall.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable global installation method.
      '';
    };
    globalInstall.method = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose the global installation method for packages.
      '';
    };
  };

  # Determine the effective installation method based on global settings
  config = lib.mkIf config.globalInstall.enable {
    csharp.installMethod = lib.mkForce config.globalInstall.method;
  };
}
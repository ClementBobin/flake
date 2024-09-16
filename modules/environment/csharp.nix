{ config, pkgs, vars, lib, ... }:

{
  # Add options for csharp
  options = {
    csharp.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable C#.
      '';
    };
    csharp.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install C# via home-manager or directly in the environment.
      '';
    };
  };

  # Install C# if desired
  config = lib.mkIf config.csharp.enable {
      home-manager.users.${vars.user} = {
        # Install C# packages
        home.packages = with pkgs; [
          dotnet-sdk_8
          #dotnet-runtime_8
          #dotnet-aspnetcore_8
        ];
      };
  };
}

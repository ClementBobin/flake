#
#  C#
#

{ config, pkgs, vars, ... }:

{
  environment = {
    C#.enable = true;
  };

  users.groups.C#.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
		dotnet-sdk_8          # Csharp
		dotnet-runtime_8
		dotnet-aspnetcore_8
  ];
}

#
#  C#
#

{ pkgs, vars, ... }:

{
  users.groups.environment.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
		dotnet-sdk_8        # Csharp
		dotnet-runtime_8
		dotnet-aspnetcore_8
  ];
}
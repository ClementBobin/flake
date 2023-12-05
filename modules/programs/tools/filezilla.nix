#
#  filezilla
#

{ config, pkgs, vars, ... }:

{
  tools = {
    filezilla.enable = true;
  };

  users.groups.filezilla.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    filezilla                  # FTP 
  ];
}

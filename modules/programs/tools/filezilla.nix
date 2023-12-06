#
#  filezilla
#

{ config, pkgs, vars, ... }:

{
  users.groups.filezilla.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    filezilla                  # FTP 
  ];
}

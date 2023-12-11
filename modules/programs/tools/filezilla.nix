#
#  filezilla
#

{ config, pkgs, vars, ... }:

{
  users.groups.tools.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    filezilla                  # FTP 
  ];
}

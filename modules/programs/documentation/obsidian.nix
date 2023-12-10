#
#  obsidian
#

{ config, pkgs, vars, ... }:

{
  users.groups.documentation.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    obsidian                  # documentation Markdown
  ];
}

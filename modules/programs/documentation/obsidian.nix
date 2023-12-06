#
#  obsidian
#

{ config, pkgs, vars, ... }:

{
  users.groups.obsidian.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    obsidian                  # documentation Markdown
  ];
}

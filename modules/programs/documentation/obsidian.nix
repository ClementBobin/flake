#
#  obsidian
#

{ config, pkgs, vars, ... }:

{
  documentation = {
    obsidian.enable = true;
  };

  users.groups.obsidian.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    obsidian                  # documentation Markdown
  ];
}

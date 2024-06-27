#
#  nodejs
#

{ config, pkgs, vars, ... }:

{
  users.groups.environment.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    nodejs_20                  # nodejs
    nodePackages.vercel        # vercel cli
    graphite-cli               # graphite terminal
    commitlint                 # commit help
  ];
}

#
#  php
#

{ pkgs, vars, ... }:

{
  users.groups.environment.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    php82Extensions.xdebug
    php82Extensions.sqlsrv
  ];

  services.httpd.phpPackage = pkgs.php.buildEnv {
    extensions = ({ enabled, all }: enabled ++ (with all; [
        xdebug
        sqlsrv
    ]));
    extraConfig = ''
        xdebug.mode=debug
    '';
  };
}
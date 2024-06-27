{ config, pkgs, ... }:

  #let
    #mssqlOdbc = pkgs.stdenv.mkDerivation {
      #name = "mssql-odbc";
      #src = pkgs.fetchurl {
        #url = "https://go.microsoft.com/fwlink/?linkid=2266742"; # Replace with the correct URL for your driver version
        #sha256 = "sha256-6f44c3d46f8ea5a6ab86cdcabe631233d7134c602e2a20ffb81c77d51ab6f6dc";
      #};
      #buildInputs = [ pkgs.unzip ];
      #installPhase = ''
        #mkdir -p $out/lib
        #tar -xzf $src -C $out/lib --strip-components=1
      #'';
    #};
  #in
  {
    users.groups.environment.members = [ "mirage" ];

    environment.systemPackages = [
      pkgs.python3
      pkgs.python3Packages.pip
      pkgs.python3Packages.numpy
      #mssqlOdbc
      (pkgs.php.buildEnv {
        extensions = ({ enabled, all }: enabled ++ (with all; [
          xdebug
          sqlsrv
          pdo_sqlsrv
        ]));
        extraConfig = ''
          [PHP]
          [Syslog]
          define_syslog_variables=Off
          [Session]
          define_syslog_variables=Off
          [Date]
          date.timezone=Europe/Berlin
          [MySQL]
          mysql.allow_local_infile=On
          mysql.allow_persistent=On
          mysql.cache_size=2000
          mysql.max_persistent=-1
          mysql.max_link=-1
          mysql.default_port=3306
          mysql.default_socket="MySQL"
          mysql.connect_timeout=3
          mysql.trace_mode=Off
          [Sybase-CT]
          sybct.allow_persistent=On
          sybct.max_persistent=-1
          sybct.max_links=-1
          sybct.min_server_severity=10
          sybct.min_client_severity=10
          [MSSQL]
          mssql.allow_persistent=On
          mssql.max_persistent=-1
          mssql.max_links=-1
          mssql.min_error_severity=10
          mssql.min_message_severity=10
          mssql.compatibility_mode=Off
          mssql.secure_connection=Off
          zend_extension=xdebug
          xdebug.mode=debug
          xdebug.start_with_request=yes
          extension=sqlsrv
          extension=pdo_sqlsrv
        '';
      })
    ];

    environment.variables = {
      PHP_INI_SCAN_DIR = "/nix/store/jzq5y2f3ivhyapw69rr3vzwqr391psaw-php-8.2.13/etc/php";
    };
  }

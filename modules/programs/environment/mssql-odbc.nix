{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "mssql-odbc";
  src = pkgs.fetchurl {
    url = "https://go.microsoft.com/fwlink/?linkid=2133323"; # Change this URL to the correct driver version
    sha256 = "sha256-value"; # Replace with the actual sha256 value of the downloaded driver
  };
  buildInputs = [ pkgs.unzip ];
  installPhase = ''
    mkdir -p $out/lib
    tar -xzf $src -C $out/lib --strip-components=1
  '';
}

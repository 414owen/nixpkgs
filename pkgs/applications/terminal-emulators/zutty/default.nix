{ lib, stdenv, fetchFromGitHub, pkg-config, freetype, python3, libX11, libXmu, libGL }:

with lib;

stdenv.mkDerivation rec {
  pname = "zutty";
  version = "0.8";

  src = fetchFromGitHub {
    owner = "tomszilagyi";
    repo = "zutty";
    rev = "${version}";
    sha256 = "sha256-Ig2Z0+GdIhn4vsYaNYS5AFeBKy3yx8IAPEHAK8YsPOY=";
  };

  nativeBuildInputs = [
    python3
    pkg-config
  ];

  buildInputs = [
    freetype
    libX11
    libXmu
    libGL
  ];

  configurePhase = ''
    python3 ./waf configure
  '';

  buildPhase = ''
    python3 ./waf
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp build/src/zutty $out/bin/
  '';

  meta = {
    homepage = "https://github.com/tomszilagyi/zutty";
    description = "Zero-cost Unicode Teletype";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ _414owen ];
    platforms = platforms.linux;
  };
}

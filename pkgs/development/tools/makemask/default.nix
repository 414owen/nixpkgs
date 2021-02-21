{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "makemask";
  version = "0.2.0";

  goPackagePath = "github.com/trhodeos/makemask";

  src = fetchFromGitHub {
    owner = "trhodeos";
    repo = "makemask";
    rev = "5f6184cf765b925264de948277f1e22a7491ad34";
    sha256 = "1g7spsqgha1aw7findvccwvcmpwcfgddqv5qmnb9qzinn7xfq0na";
  };

  goDeps = ./deps.nix;

  meta = with lib; {
    description = "A tool to add the final touched to Nintendo64 roms";
    homepage = "https://github.com/trhodeos/makemask";
    license = licenses.gpl2;
    maintainers = [ maintainers._414owen ];
  };
}

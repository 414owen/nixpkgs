{ lib, stdenv
, cmake
, fetchFromGitHub
, nix-update-script
, pantheon
, pkgconfig
, meson
, ninja
, vala
, python3
, evolution-data-server
, desktop-file-utils
, gtk3
, granite
, libgee
, elementary-icon-theme
, appstream
, libpeas
, libhandy
, editorconfig-core-c
, gtksourceview3
, gtkspell3
, libsoup
, vte
, webkitgtk
, zeitgeist
, ctags
, libgit2-glib
, wrapGAppsHook
, sqlite
, folks
}:

stdenv.mkDerivation rec {
  pname = "elementary-mail";
  version = "1.0.8";

  repoName = "mail";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "62422a67e19e42367595147a308237515b4bcc24";
    sha256 = "088p82bi1glq8y5sr57mjid0cr87vpbdkjn1r9i7fr54nx8i8f1k";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    # cmake
    libhandy
    appstream
    desktop-file-utils
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    evolution-data-server
    folks
    sqlite
    elementary-icon-theme
    libhandy
    granite
    gtk3
    libgee
    webkitgtk
  ];

  # install script fails with UnicodeDecodeError because of printing a fancy elipsis character
  LC_ALL = "C.UTF-8";

  # ctags needed in path by outline plugin
  preFixup = ''
    gappsWrapperArgs+=(
      --prefix PATH
    )
  '';

  postPatch = ''
    # chmod +x meson/post_install.py
    # patchShebangs meson/post_install.py
  '';

  meta = with lib; {
    description = "Mail client designed for elementary OS";
    homepage = "https://github.com/elementary/mail";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}

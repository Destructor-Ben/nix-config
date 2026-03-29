{ stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "destructor-ben-fonts";
  version = "1.0";
  src = ../fonts;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    cp -r $src/*.{ttf,otf} $out/share/fonts/truetype/
  '';
}

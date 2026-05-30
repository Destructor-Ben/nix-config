{ stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "destructor-ben-fonts";
  version = "1.0";
  src = ../fonts;
  dontBuild = true;
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype/
    find . -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp {} $out/share/fonts/truetype/ \;

    runHook postInstall
  '';
}

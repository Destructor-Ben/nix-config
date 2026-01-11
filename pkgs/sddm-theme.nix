{ stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "destructor-ben-sddm-theme";
  version = "1.0";
  src = ../themes/sddm;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/sddm/themes/destructor-ben
    cp -r $src/* $out/share/sddm/themes/destructor-ben
  '';
}

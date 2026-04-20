{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  bash,
  just,
  catppuccin-whiskers,
  kdePackages,
  flavor ? "mocha",
  accent ? "mauve",
  font ? "Noto Sans",
  fontSize ? "9",
  background ? null,
  disableBackground ? false,
  loginBackground ? false,
  userIcon ? false,
  clockEnabled ? true,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "catppuccin-sddm-reworked";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "Destructor-Ben";
    repo = "sddm-theme";
    tag = "v${finalAttrs.version}";
    hash = "sha256-mfec8WhPwk3YtlhX1vdBQN3EjRzlTdGGZMwYSv9sIZU=";
  };

  dontWrapQtApps = true;

  nativeBuildInputs = [
    just
    catppuccin-whiskers
  ];

  propagatedBuildInputs = [
    kdePackages.qtsvg
  ];

  postPatch = ''
    substituteInPlace justfile \
      --replace-fail '#!/usr/bin/env bash' '#!${lib.getExe bash}'
  '';

  buildPhase = ''
    runHook preBuild

    just build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/sddm/themes/"
    cp -r themes/catppuccin-${flavor}-${accent} "$out/share/sddm/themes/catppuccin-${flavor}-${accent}"

    configFile=$out/share/sddm/themes/catppuccin-${flavor}-${accent}/theme.conf

    runHook postInstall
  '';

  postFixup = ''
    mkdir -p $out/nix-support
    echo ${kdePackages.qtsvg} >> $out/nix-support/propagated-user-env-packages
  '';

  meta = {
    description = "Soothing pastel theme for SDDM";
    homepage = "https://github.com/catppuccin/sddm";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gipphe ];
    platforms = lib.platforms.linux;
  };
})

/*



    substituteInPlace $configFile \
      --replace-fail 'Font="Noto Sans"' 'Font="${font}"' \
      --replace-fail 'FontSize=9' 'FontSize=${fontSize}'

    ${lib.optionalString (background != null) ''
      substituteInPlace $configFile \
        --replace-fail 'Background="backgrounds/wall.png"' 'Background="${background}"'
    ''}

    ${lib.optionalString disableBackground ''
      substituteInPlace $configFile \
        --replace-fail 'CustomBackground="true"' 'CustomBackground="false"'
    ''}

    ${lib.optionalString loginBackground ''
      substituteInPlace $configFile \
        --replace-fail 'LoginBackground="false"' 'LoginBackground="true"'
    ''}

    ${lib.optionalString userIcon ''
      substituteInPlace $configFile \
        --replace-fail 'UserIcon="false"' 'UserIcon="true"'
    ''}

    ${lib.optionalString (!clockEnabled) ''
      substituteInPlace $configFile \
        --replace-fail 'ClockEnabled="true"' 'ClockEnabled="false"'
    ''}
*/

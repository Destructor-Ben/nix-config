{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Prism launcher sometimes fails to find glx when loading minecraft, this fixes it
    (writeShellScriptBin "prismlauncher-wrapped" ''
      export LD_LIBRARY_PATH="${lib.makeLibraryPath [ libGL ]}:$LD_LIBRARY_PATH"
      exec prismlauncher "$@"
    '')

    # tModLoader needs a custom dev environment to run in, this helps with it
    (writeShellScriptBin "tml" ''
      TODO
    '')

    # Rider and IntelliJ need their respective SDKs installed
    (writeShellScriptBin "rider-wrapped" ''
      nds dotnet
      exec rider "$@"
    '')

    (writeShellScriptBin "idea-ultimate-wrapped" ''
      nds java
      exec idea-ultimate "$@"
    '')
  ];
}

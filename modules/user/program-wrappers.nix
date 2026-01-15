{ pkgs, ... }:
{
  # Prism launcher sometimes fails to find glx when loading minecraft, this fixes it
  home.packages = with pkgs; [
    (writeShellScriptBin "prismlauncher-wrapped" ''
      export LD_LIBRARY_PATH="${lib.makeLibraryPath [ libGL ]}:$LD_LIBRARY_PATH"
      exec prismlauncher "$@"
    '')
  ];
}

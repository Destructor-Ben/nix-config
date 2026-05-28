{ pkgs, unstable }:
pkgs.mkShell {
  packages = with pkgs; [
    dotnetCorePackages.sdk_8_0-bin
  ];
}

{ pkgs, unstable }:
pkgs.mkShell {
  packages = with pkgs; [
    jdk
    gradle
  ];
}

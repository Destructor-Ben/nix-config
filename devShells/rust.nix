{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    rustc
    cargo
  ];
}

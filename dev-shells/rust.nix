{ pkgs, unstable }:
pkgs.mkShell {
  packages = with pkgs; [
    rustc
    cargo
  ];
}

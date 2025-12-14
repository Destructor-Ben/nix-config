{ pkgs, unstable }:
pkgs.mkShell {
  packages = with pkgs; [
    zig
    zls
  ];
}

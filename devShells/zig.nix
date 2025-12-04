{ pkgs, unstable }:
pkgs.mkShell {
  packages = with pkgs; [
    unstable.zig
    zls
  ];
}

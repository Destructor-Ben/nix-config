{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    zig # TODO: install zig from unstable branch to get zig 0.15
    zls
  ];
}

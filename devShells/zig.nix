{ pkgs, unstable }:
pkgs.mkShell {
  packages = with pkgs; [
    unstable.zig # TODO: install zig from unstable branch to get zig 0.15
    zls
  ];
}

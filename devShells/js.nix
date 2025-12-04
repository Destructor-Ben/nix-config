{ pkgs, unstable }:
pkgs.mkShell {
  packages = with pkgs; [
    deno
  ];
}

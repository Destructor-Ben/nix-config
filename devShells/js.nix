{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    deno
  ];
}

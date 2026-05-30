{ pkgs, unstable }:
pkgs.mkShell {
  packages = with pkgs; [
    javaPackages.compiler.openjdk21
    unstable.gradle_9
  ];
}

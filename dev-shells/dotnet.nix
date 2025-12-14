{ pkgs, unstable }:
pkgs.mkShell {
  packages = with pkgs; [
    (dotnetCorePackages.combinePackages [
      dotnetCorePackages.sdk_10_0-bin
      dotnetCorePackages.sdk_8_0-bin
    ])
  ];
}

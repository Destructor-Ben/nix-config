{ pkgs, unstable }:
pkgs.mkShell {
  packages = with pkgs; [
    jdk
    gradle
  ];
  
  # TODO: move this into dev shells for java applications
  #environment.variables = {
  #  _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
  #};
}

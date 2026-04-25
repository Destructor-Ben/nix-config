{ pkgs, ... }:
{
  # TODO: do this properly
  home.packages = with pkgs; [
    (writeShellScriptBin "hi" (builtins.readFile ./hi.sh))
  ];
}

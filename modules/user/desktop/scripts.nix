{ pkgs, lib, ... }:
let
  fs = lib.fileset;
  scriptPaths = fs.toList (fs.fileFilter (file: lib.hasSuffix ".sh" file.name) ../../../scripts);
  scriptPkgs = builtins.listToAttrs (map (path: 
    let
      name = lib.removeSuffix ".sh" (baseNameOf path);
    in
    {
      inherit name;
      value = pkgs.writeShellScriptBin name path;
    }
  ) scriptPaths);
in
{
  # Auto scan for scripts in the scripts folder and add them to the home dir
  home.packages = builtins.attrValues scriptPkgs;
}

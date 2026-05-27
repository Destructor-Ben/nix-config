{ pkgs, lib, theme, ... }:
let
  fs = lib.fileset;
  scriptPaths = fs.toList (fs.fileFilter (file: lib.hasSuffix ".sh" file.name) ../../../scripts);
  scriptPkgs = builtins.listToAttrs (map (path: 
    let
      name = lib.removeSuffix ".sh" (baseNameOf path);
      rawContents = builtins.readFile path;
      finalContents = if name == "wlogout-custom"
        then lib.replaceStrings
          [ "@BUTTON_SIZE@" "@PADDING@" "@SCREEN_WIDTH@" "@SCREEN_HEIGHT@" ]
          [ (toString 150) (toString (theme.padding * 2)) (toString 1920) (toString 1080) ]
          rawContents
        else rawContents;
    in
    {
      inherit name;
      value = pkgs.writeShellScriptBin name finalContents;
    }
  ) scriptPaths);
in
{
  # Auto scan for scripts in the scripts folder and add them to the home dir
  home.packages = builtins.attrValues scriptPkgs;
}

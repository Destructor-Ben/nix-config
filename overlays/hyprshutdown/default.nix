final: prev: {
  wlogout = prev.hyprshutdown.overrideAttrs (oldAttrs: {
    prePatch = ''
      diff -u ${./src/ui/UI.cpp} ${./src/ui/UI.modified.cpp} > src/ui/UI.cpp.patch || true
      patch src/ui/UI.cpp < src/ui/UI.cpp.patch
    '';
  });
}

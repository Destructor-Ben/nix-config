final: prev: {
  hyprshutdown = prev.hyprshutdown.overrideAttrs (oldAttrs: {
    prePatch = ''
      diff -u ${./src/ui/UI.cpp} ${./src/ui/UI.modified.cpp} > src/ui/UI.cpp.patch || true
      patch src/ui/UI.cpp < src/ui/UI.cpp.patch

      diff -u ${./src/ui/UI.hpp} ${./src/ui/UI.modified.hpp} > src/ui/UI.hpp.patch || true
      patch src/ui/UI.hpp < src/ui/UI.hpp.patch
    '';
  });
}

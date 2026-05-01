final: prev: {
  wlogout = prev.wlogout.overrideAttrs (oldAttrs: {
    prePatch = ''
      diff -u ${./main.c} ${./main.modified.c} > main.c.patch || true
      patch main.c < main.c.patch
    '';
  });
}

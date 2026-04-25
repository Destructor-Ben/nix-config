final: prev: {
  wlogout = prev.wlogout.overrideAttrs (oldAttrs: {
    prePatch = ''
      cp ${./main.c} main.c
    '';
  });
}

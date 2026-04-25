final: prev: {
  plymouth = prev.plymouth.overrideAttrs (oldAttrs: {
    prePatch = ''
      cp ${./spinfinity.plymouth.in} themes/spinfinity/spinfinity.plymouth.in
    '';
  });
}
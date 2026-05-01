final: prev: {
  plymouth = prev.plymouth.overrideAttrs (oldAttrs: {
    # TODO: make my own plymouth theme at some point properly
    # prePatch = ''
    #   cp ${./spinfinity.plymouth.in} themes/spinfinity/spinfinity.plymouth.in
    # '';
  });
}
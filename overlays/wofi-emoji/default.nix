final: prev: {
  wofi-emoji = prev.wofi-emoji.overrideAttrs (oldAttrs: {
    postPatch = oldAttrs.postPatch + ''
      substituteInPlace wofi-emoji \
        --replace-fail '-p "emoji"' '-p "Search emoji"'
    '';
  });
}

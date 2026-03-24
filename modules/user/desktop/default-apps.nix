{ lib, pkgs-stable, ... }:
let
  browser = "zen.desktop";
  editor = "code.desktop"; # TODO: change to vscodium
  file-manager = "dolphin.desktop"; # TODO: potentially update this?
  image-viewer = "gwenview.desktop";
  # TODO: add these + vscode to the context menu
  bitmap-editor = "gimp.desktop";
  svg-editor = "inkscape.desktop";
in {
  # TODO: this doesn't work - is probably because of dolphin
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # TODO: see if any file types are missing
      "inode/directory" = file-manager;

      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/chrome" = browser;
      "application/xhtml+xml" = browser;
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xhtml" = browser;
      "application/x-extension-xht" = browser;

      "image/jpeg" = image-viewer;
      "image/bmp" = image-viewer;
      "image/gif" = image-viewer;
      "image/jpg" = image-viewer;
      "image/pjpeg" = image-viewer;
      "image/png" = image-viewer;
      "image/tiff" = image-viewer;
      "image/webp" = image-viewer;
      "image/x-bmp" = image-viewer;
      "image/x-gray" = image-viewer;
      "image/x-icb" = image-viewer;
      "image/x-ico" = image-viewer;
      "image/x-png" = image-viewer;
      "image/x-portable-anymap" = image-viewer;
      "image/x-portable-bitmap" = image-viewer;
      "image/x-portable-graymap" = image-viewer;
      "image/x-portable-pixmap" = image-viewer;
      "image/x-xbitmap" = image-viewer;
      "image/x-xpixmap" = image-viewer;
      "image/x-pcx" = image-viewer;
      "image/svg+xml" = image-viewer;
      "image/svg+xml-compressed" = image-viewer;
      "image/vnd.wap.wbmp" = image-viewer;
      "image/x-icns" = image-viewer;
    };
  };
}

/* TODO: ensure these are included
[Added Associations]
application/x-extension-htm=zen.desktop;
application/x-extension-html=zen.desktop;
application/x-extension-shtml=zen.desktop;
application/x-extension-xht=zen.desktop;
application/x-extension-xhtml=zen.desktop;
application/xhtml+xml=zen.desktop;
model/obj=blender.desktop;
text/html=zen.desktop;
text/plain=code.desktop;
x-scheme-handler/chrome=zen.desktop;
x-scheme-handler/http=zen.desktop;
x-scheme-handler/https=zen.desktop;

[Default Applications]
application/x-extension-htm=zen.desktop
application/x-extension-html=zen.desktop
application/x-extension-shtml=zen.desktop
application/x-extension-xht=zen.desktop
application/x-extension-xhtml=zen.desktop
application/xhtml+xml=zen.desktop
model/obj=blender.desktop;
text/html=zen.desktop
text/plain=code.desktop;
x-scheme-handler/chrome=zen.desktop
x-scheme-handler/http=zen.desktop
x-scheme-handler/https=zen.desktop
x-scheme-handler/obsidian=obsidian.desktop
x-scheme-handler/x-github-client=github-desktop.desktop
x-scheme-handler/x-github-desktop-auth=github-desktop.desktop

*/
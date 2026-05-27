{ lib, pkgs, ... }:
let
  # Utils
  browser = "zen.desktop";
  terminal = "kitty.desktop";
  file-manager = "nemo.desktop";

  # Viewers
  image-viewer = "org.gnome.Loupe.desktop";
  video-player = "vlc.desktop";
  audio-player = "vlc.desktop";

  # Editors
  code-editor = "codium.desktop"; # TODO: open in codium in context menu (under Open in Terminal), also allow opening artbitrary files in codium
  model-editor = "blender.desktop";
  notes-editor = "obsidian.desktop";
in
{
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "codium";
    TERMINAL = "kitty";
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ terminal ];
    };
  };

  # TODO: nemo doesn't respect the default terminal for open in terminal
  dconf.settings = {
    "org/cinnamon/desktop/default-applications/terminal" = {
      exec = "kitty";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = file-manager;
      "application/x-gnome-saved-search" = file-manager;
      "x-scheme-handler/terminal" = terminal;
      "text/plain" = code-editor;
      "model/obj" = model-editor;
      "x-scheme-handler/obsidian" = notes-editor;

      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/chrome" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;
      "application/xhtml+xml" = browser;
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xhtml" = browser;
      "application/x-extension-xht" = browser;
      "application/pdf" = browser;
      "image/svg+xml" = browser;
      "image/svg+xml-compressed" = browser;

      "image/png" = image-viewer;
      "image/jpg" = image-viewer;
      "image/jpeg" = image-viewer;
      "image/pjpeg" = image-viewer;
      "image/bmp" = image-viewer;
      "image/gif" = image-viewer;
      "image/tiff" = image-viewer;
      "image/webp" = image-viewer;
      "image/heic" = image-viewer;
      "image/heif" = image-viewer;
      "image/avif" = image-viewer;
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
      "image/vnd.wap.wbmp" = image-viewer;
      "image/x-icns" = image-viewer;

      "video/mp4" = video-player;
      "video/mpeg" = video-player;
      "video/quicktime" = video-player;
      "video/webm" = video-player;
      "video/x-matroska" = video-player;
      "video/x-ms-wmv" = video-player;
      "video/x-flv" = video-player;
      "video/x-msvideo" = video-player;

      "audio/mp4" = audio-player;
      "audio/mpeg" = audio-player;
      "audio/ogg" = audio-player;
      "audio/wav" = audio-player;
      "audio/webm" = audio-player;
      "audio/flac" = audio-player;
      "audio/x-matroska" = audio-player;
      "audio/aac" = audio-player;
    };
  };
}

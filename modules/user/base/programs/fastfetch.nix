{ theme, ... }:
{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        source = "~/nix-config/img/Nix.txt";
        type = "file";
        color = {
          "1" = theme.colors.terminal-mauve;
          "2" = theme.colors.terminal-pink;
          "3" = theme.colors.terminal-mauve;
          "4" = theme.colors.terminal-pink;
          "5" = theme.colors.terminal-mauve;
          "6" = theme.colors.terminal-pink;
        };
        padding = {
          top = 1;
          left = 2;
          right = 2;
        };
      };
      
      display = {
        separator = " = ";
        color = {
          keys = theme.colors.terminal-mauve;
          title = theme.colors.terminal-mauve;
        };
      };

      modules = [
        {
          type = "title";
          format = "{user-name-colored}{#${theme.colors.terminal-mauve}}{#1}@{#0}{host-name-colored}{#${theme.colors.terminal-mauve}}{#1}.nix{#0}";
        }

        {
          type = "custom";
          format = "{";
        }

        {
          type = "custom";
          format = "  {#${theme.colors.terminal-pink}}system{#0} = {";
        }
        {
          type = "os";
          key = "    os";
          format = "\"{pretty-name} {arch}\";";
        }
        {
          type = "kernel";
          key = "    kernel";
          format = "\"{sysname} {release}\";";
        }
        {
          type = "packages";
          key = "    packages";
          format = "\"{nix-system} (nix-system), {nix-user} (nix-user)\";";
        }
        {
          type = "custom";
          format = "  };";
        }

        "break"
        
        {
          type = "custom";
          format = "  {#${theme.colors.terminal-pink}}hardware{#0} = {";
        }
        {
          type = "host";
          key = "    host";
          format = "\"{name}\";";
        }
        {
          type = "cpu";
          showPeCoreCount = true;
          key = "    cpu";
          format = "\"{name} ({cores-logical}) @ {freq-max}\";";
        }
        {
          type = "gpu";
          driverSpecific = true;
          key = "    gpu";
          format = "\"{vendor} {name} [{type}]\";";
        }
        {
          type = "memory";
          key = "    memory";
          format = "\"{used} / {total} ({percentage})\";";
        }
        {
          type = "disk";
          key = "    disk";
          format = "\"{size-used} / {size-total} ({size-percentage})\";";
        }
        {
          type = "custom";
          format = "  };";
        }

        "break"
        
        {
          type = "custom";
          format = "  {#${theme.colors.terminal-pink}}software{#0} = {";
        }
        {
          type = "wm";
          key = "    wm";
          format = "\"{pretty-name} {version}\";";
        }
        {
          type = "terminal";
          key = "    terminal";
          format = "\"{pretty-name} {version}\";";
        }
        {
          type = "shell";
          key = "    shell";
          format = "\"{pretty-name} {version}\";";
        }
        {
          type = "editor";
          key = "    editor";
          format = "\"{exe-name} {version}\";";
        }
        {
          type = "terminalfont";
          key = "    font";
          format = "\"{name} {size}pt\";";
        }
        {
          type = "custom";
          format = "  };";
        }

        {
          type = "custom";
          format = "}";
        }
      ];
    };
  };
}

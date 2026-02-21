{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Prism launcher sometimes fails to find glx when loading minecraft, this fixes it
    (writeShellScriptBin "prismlauncher-wrapped" ''
      export LD_LIBRARY_PATH="${lib.makeLibraryPath [ libGL ]}:$LD_LIBRARY_PATH"
      exec prismlauncher "$@"
    '')

    # Runs the tML dev setup script
    # TODO: make this just call the launch script eventually once its fixed on tmls end
    (writeShellScriptBin "tml-dev" ''
      cd ~/Programming/Terraria/tModLoader

      if ! command -v git > /dev/null; 
      then
        echo "git not found in PATH"
        exit 1
      fi

      submoduleupdatemarker=".git/tml-setup-module-init.touch"
      if ! [ ".git/index" -ot "$submoduleupdatemarker" ]
      then
        echo "Restoring git submodules"
        git submodule update --init --recursive
        if [ $? -ne 0 ]
        then
          exit $?
        fi
        touch "$submoduleupdatemarker"
      fi

      if ! command -v dotnet > /dev/null
      then
        echo "dotnet not found in PATH"
        exit 1
      fi

      # dotnet run fails because it tries to launch a dynamic executable on NixOS
      # Running dotnet directly with the path to the dll avoids this
      dotnet build setup/CLI/Setup.CLI.csproj -c Release -p:WarningLevel=0 -v q
      dotnet setup/CLI/bin/Release/net8.0/setup-cli.dll
    '')

    # Rider and IntelliJ need their respective SDKs installed, and IntelliJ needs help to load OpenGL when running Minecraft
    (writeShellScriptBin "rider-wrapped" ''
      steam-run nix develop ~/nix-config#dotnet --command rider $@
    '')

    (writeShellScriptBin "idea-ultimate-wrapped" ''
      export LD_LIBRARY_PATH="${lib.makeLibraryPath [ libGL ]}:$LD_LIBRARY_PATH"
      steam-run nix develop ~/nix-config#java --command idea-ultimate $@
    '')
  ];
}

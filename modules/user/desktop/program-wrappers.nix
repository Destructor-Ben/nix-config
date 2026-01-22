{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Prism launcher sometimes fails to find glx when loading minecraft, this fixes it
    (writeShellScriptBin "prismlauncher-wrapped" ''
      export LD_LIBRARY_PATH="${lib.makeLibraryPath [ libGL ]}:$LD_LIBRARY_PATH"
      exec prismlauncher "$@"
    '')

    # tModLoader needs a custom dev environment to run in, this helps with it
    (writeShellScriptBin "tml" ''
      export TML_PATH=/home/ben/.local/share/Steam/steamapps/common/tModLoader
      cd $TML_PATH

      library_dir="$TML_PATH/Libraries/Native/Linux"
      #export LD_LIBRARY_PATH="$library_dir"
      ln -sf "$library_dir/libSDL2-2.0.so.0" "$library_dir/libSDL2.so"

      nix develop ~/nix-config#dotnet --command dotnet tModLoader.dll "$@"
    '')

    # Runs the tModLoader setup script
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

      # NixOS can't run dynamically linked executables, hence it needs to be run via steam-run
      # However, dotnet build fails in a steam-run environment because the temp folder is messed up
      dotnet build setup/CLI/Setup.CLI.csproj -c Release -p:WarningLevel=0 -v q
      steam-run dotnet setup/CLI/bin/Release/net8.0/setup-cli.dll "$@"
    '')

    # Rider and IntelliJ need their respective SDKs installed
    (writeShellScriptBin "rider-wrapped" ''
      nix develop ~/nix-config#dotnet --command rider $@
    '')

    (writeShellScriptBin "idea-ultimate-wrapped" ''
      nix develop ~/nix-config#java --command idea-ultimate $@
    '')
  ];
}

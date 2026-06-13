{
  description = "Destructor_Ben's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hytale-launcher = {
      url = "github:TNAZEP/HytaleLauncherFlake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-theme = {
      url = "github:Destructor-Ben/sddm-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }@inputs:
  let
    system = "x86_64-linux";

    stable-overlays = import ./overlays/stable.nix;
    unstable-overlays = import ./overlays/unstable.nix;

    pkgs-stable = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = stable-overlays;
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
      overlays = unstable-overlays;
    };

    devShellArgs = {
      pkgs = pkgs-stable;
      unstable = pkgs-unstable;
    };

    moduleArgs = {
      inherit(inputs) hytale-launcher zen-browser sddm-theme;
      unstable = pkgs-unstable;

      theme = import ./theme.nix;
      custom-fonts = pkgs-stable.callPackage ./pkgs/custom-fonts.nix {};
    };
  in
  {
    nixosConfigurations = {
      bens-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = moduleArgs;
        modules = [
          ./hosts/bens-laptop/configuration.nix
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          {
            nixpkgs.pkgs = pkgs-stable;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = moduleArgs;
            home-manager.users.ben = ./hosts/bens-laptop/home.nix;
          }
        ];
      };
    };

    # Devshells are intended to be used for personal projects or for messing around with programming languages
    # I don't care how bad of an idea this is supposed to be
    devShells.${system} = let
      lib = nixpkgs.lib;
      dir-contents = builtins.readDir ./dev-shells;

      nix-files = lib.filterAttrs 
        (name: type: type == "regular" && lib.hasSuffix ".nix" name) 
        dir-contents;

      imported-shells = lib.mapAttrs 
        (name: type: import (./dev-shells + "/${name}") devShellArgs) 
        nix-files;

      clean-shells = lib.mapAttrs' 
        (name: value: lib.nameValuePair (lib.removeSuffix ".nix" name) value) 
        imported-shells;
    in
      clean-shells;
  };
}

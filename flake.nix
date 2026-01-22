{
  description = "Destructor_Ben's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hytale-launcher.url = "github:TNAZEP/HytaleLauncherFlake";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, plasma-manager, ... }@inputs:
  let
    system = "x86_64-linux";

    pkgs-stable = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    pkgs-overlay = {
      nixpkgs.pkgs = pkgs-stable;

      nixpkgs.overlays = [
        (final: prev: {
          unstable = pkgs-unstable;
        })
      ];
    };

    devShellArgs = {
      pkgs = pkgs-stable;
      unstable = pkgs-unstable;
    };
  in
  {
    nixosConfigurations = {
      bens-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/bens-laptop/configuration.nix
          pkgs-overlay
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.ben = ./hosts/bens-laptop/home.nix;
          }
        ];
      };
    };

    # Devshells are intended to be used for personal projects or for messing around with programming languages
    # I don't care how bad of an idea this is supposed to be
    devShells.${system} = {
      dotnet = import ./dev-shells/dotnet.nix devShellArgs;
      java = import ./dev-shells/java.nix devShellArgs;
      js = import ./dev-shells/js.nix devShellArgs;
      rust = import ./dev-shells/rust.nix devShellArgs;
      zig = import ./dev-shells/zig.nix devShellArgs;
    };
  };
}

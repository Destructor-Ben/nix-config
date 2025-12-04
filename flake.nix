{
  description = "Destructor_Ben's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
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
          {
            nixpkgs.pkgs = pkgs-stable;

            nixpkgs.overlays = [
              (final: prev: {
                unstable = pkgs-unstable;
              })
            ];
          }

          ./hosts/bens-laptop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.ben = ./users/ben/home.nix;
          }
        ];
      };
    };

    devShells.${system} = {
      dotnet = import ./devShells/dotnet.nix devShellArgs;
      java = import ./devShells/java.nix devShellArgs;
      js = import ./devShells/js.nix devShellArgs;
      rust = import ./devShells/rust.nix devShellArgs;
      zig = import ./devShells/zig.nix devShellArgs;
    };
  };
}

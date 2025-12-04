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

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: {
    nixosConfigurations = {
      bens-laptop = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/bens-laptop/configuration.nix
          ./hosts/bens-laptop/hardware-configuration.nix
          ./modules/base
          ./modules/desktop

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
  };
}

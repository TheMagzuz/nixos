{
  description = "My NixOS Flake";

  inputs = {
    # nixpkgs.url ="github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ...}@inputs: {
    nixosConfigurations = let
      commonModules = [
        ./configuration.nix
      ];
      specialArgs = { };
    in {
      "laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/laptop/hardware-configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.markus = import ./hosts/laptop/home.nix;
          }
        ] ++ commonModules;
        inherit specialArgs;
      };
      "desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/desktop/hardware-configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.markus = import ./hosts/desktop/home.nix;
          }
        ] ++ commonModules;
        inherit specialArgs;
      };
    };
  } // flake-utils.lib.eachDefaultSystem (system:
     let pkgs = nixpkgs.legacyPackages.${system}; in {
       devShells.default = import ./shell.nix { inherit pkgs; };
     }
   );
}

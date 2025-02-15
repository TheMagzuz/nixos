{
  description = "My NixOS Flake";

  inputs = {
    # nixpkgs.url ="github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    ...
  } @ inputs:
    {
      nixosConfigurations = let
        commonModules = [
          ./configuration.nix
          inputs.sops-nix.nixosModules.sops
        ];
        homeModules = [
          inputs.sops-nix.homeManagerModules.sops
          inputs.nvf.homeManagerModules.default
        ];
        specialArgs = {};
      in {
        "vulpes" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules =
            [
              ./hosts/laptop/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.magz = import ./hosts/laptop/home.nix;
                home-manager.sharedModules = homeModules;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                };
              }
            ]
            ++ commonModules;
          inherit specialArgs;
        };
        "lupus" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules =
            [
              ./hosts/desktop/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.magz = import ./hosts/desktop/home.nix;
                home-manager.sharedModules = homeModules;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                };
              }
            ]
            ++ commonModules;
          inherit specialArgs;
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = import ./shell.nix {inherit pkgs;};
      }
    );
}

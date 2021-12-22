{
    description = "My NixOS/home-manager configuration.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager }: {

        # System configuration
        nixosConfigurations.tuxedo = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                # The system configuration
                ./nix/tuxedo.nix

                # Home manager configutation
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.gaetan = import ./nix/home.nix;
                }
            ];
        };
    };
}

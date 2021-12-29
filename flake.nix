{
    description = "My NixOS/home-manager configuration.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
             url = "github:nix-community/home-manager";
             inputs.nixpkgs.follows = "nixpkgs";
        };

        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    };

    outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay }:
        let
            overlays = [
                neovim-nightly-overlay.overlay
            ];

        in {

            # System configuration
            nixosConfigurations.tuxedo = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    # The system configuration
                    ./nix/tuxedo.nix
                    { nixpkgs.overlays = overlays; }

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

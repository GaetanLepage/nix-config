# ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
# ██ ▄▄ █ ▄▄▀█ ▄▄█▄ ▄█ ▄▄▀█ ▄▄▀████ ████ ▄▄█▀▄▄▀█ ▄▄▀█ ▄▄▄█ ▄▄██
# ██ █▀▀█ ▀▀ █ ▄▄██ ██ ▀▀ █ ██ ████ ████ ▄▄█ ▀▀ █ ▀▀ █ █▄▀█ ▄▄██
# ██ ▀▀▄█▄██▄█▄▄▄██▄██▄██▄█▄██▄████ ▀▀ █▄▄▄█ ████▄██▄█▄▄▄▄█▄▄▄██
# ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
# website:  glepage.com
# github:   https://github.com/gaetanlepage
# email:    gaetan.lepage@inria.fr
#
# #------------------------------------------------#
# | Nix flake configuration (NixOS + home-manager) |
# #------------------------------------------------#

{
    description = "My NixOS/home-manager configuration.";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        # nixpkgs.url = "/home/gaetan/perso/nixpkgs";

        home-manager = {
             url = "github:nix-community/home-manager/master";
             # url = "/home/gaetan/perso/home-manager";
             inputs.nixpkgs.follows = "nixpkgs";
        };

        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        neovim-nightly-overlay
    }:
        let
            overlays = [
                neovim-nightly-overlay.overlay
            ];
            overlayModule = {
                nixpkgs.overlays = overlays;
                # nixpkgs.config = { allowUnfree = true; };
            };

            system = "x86_64-linux";

        in {

            # System configuration
            nixosConfigurations.tuxedo = nixpkgs.lib.nixosSystem {

                inherit system;

                modules = [
                    # The system configuration
                    ./nixos/tuxedo-configuration.nix
                    overlayModule

                    # Home manager configuration
                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.gaetan = import ./home/tuxedo.nix;
                        };
                    }
                ];
            };

            homeConfigurations.inria = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.${system};

                modules = [
                    overlayModule
                    ./home/inria.nix
                ];
            };
        };
}

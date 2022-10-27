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
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
    }:
        let
            system = "x86_64-linux";

            # Export the nixpkgs flake output to /etc
            nixpkgs-outPath = {
                environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
            };

        in {

            # Tuxedo laptop
            nixosConfigurations.tuxedo = nixpkgs.lib.nixosSystem {

                inherit system;

                modules = [
                    # The system configuration
                    ./nixos/tuxedo
                    nixpkgs-outPath

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

            # Cuda desktop
            nixosConfigurations.cuda = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./nixos/cuda
                    nixpkgs-outPath
                ];
            };

            # Inria
            homeConfigurations.inria = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.${system};

                modules = [ ./home/inria.nix ];
            };
        };
}

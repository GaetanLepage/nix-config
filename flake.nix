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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "/home/gaetan/perso/nix/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      # url = "/home/gaetan/perso/nix/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
  }: let
    system = "x86_64-linux";

    # Export the nixpkgs flake output to /etc
    nixpkgs-outPath = {
      environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
    };
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations = {
      # Tuxedo laptop
      tuxedo = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          # The system configuration
          ./nixos/tuxedo
          nixpkgs-outPath

          # agenix
          agenix.nixosModules.default
          {environment.systemPackages = [agenix.packages.x86_64-linux.default];}

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
      cuda = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/cuda
          nixpkgs-outPath
          agenix.nixosModules.default
        ];
      };
    };

    # Inria
    homeConfigurations.inria = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [./home/inria.nix];
    };
  };
}

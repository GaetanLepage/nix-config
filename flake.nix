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

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      # url = "/home/gaetan/perso/nix/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # url = "/home/gaetan/perso/nix/nixvim/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    agenix,
    agenix-rekey,
    disko,
    flake-parts,
    home-manager,
    nix-index-database,
    nixos-hardware,
    nixpkgs,
    nixvim,
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;

      flake = let
        system = "x86_64-linux";
        homeManagerModules = hostname: [
          nixvim.homeManagerModules.nixvim
          nix-index-database.hmModules.nix-index
          ./home/hosts/${hostname}
        ];
      in {
        agenix-rekey = agenix-rekey.configure {
          userFlake = self;
          nodes = self.nixosConfigurations;
        };

        nixosConfigurations = let
          mkHost = hostname: extraModules:
            nixpkgs.lib.nixosSystem {
              inherit system;

              modules =
                [
                  # The system configuration
                  ./nixos/${hostname}
                  {nix.nixPath = ["nixpkgs=${nixpkgs.outPath}"];}

                  # disko
                  disko.nixosModules.disko

                  # agenix
                  agenix.nixosModules.default
                  agenix-rekey.nixosModules.default
                  {age.rekey.localStorageDir = ./.secrets/${hostname};}

                  # Home manager configuration
                  home-manager.nixosModules.home-manager
                  {
                    home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      users.gaetan.imports = homeManagerModules hostname;
                    };
                  }
                ]
                ++ extraModules;
            };
        in {
          framework = mkHost "framework" [
            nixos-hardware.nixosModules.framework-13-7040-amd
          ];
          cuda = mkHost "cuda" [];
        };

        # Inria
        homeConfigurations.inria = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = {
              allowUnfree = true;
              cudaSupport = true;
            };
          };
          modules = homeManagerModules "inria";
        };
      };

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        formatter = pkgs.alejandra;

        packages = let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [agenix-rekey.overlays.default];
          };
        in {
          agenix = pkgs.agenix-rekey;
        };

        devShells.default = pkgs.mkShellNoCC {
          packages = builtins.attrValues config.packages;
        };
      };
    };
}

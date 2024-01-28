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
    nixpkgs,
    home-manager,
    agenix,
    nixvim,
    nix-index-database,
  }: let
    system = "x86_64-linux";
    inherit (import nixpkgs {inherit system;}) lib;

    homeManagerModules = hostname: [
      nixvim.homeManagerModules.nixvim
      nix-index-database.hmModules.nix-index
      ./home/hosts/${hostname}
    ];
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations = let
      mkHost = hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            # The system configuration
            ./nixos/${hostname}
            {nix.nixPath = ["nixpkgs=${nixpkgs.outPath}"];}

            # agenix
            agenix.nixosModules.default
            {environment.systemPackages = [agenix.packages.x86_64-linux.default];}

            # Home manager configuration
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.gaetan.imports = homeManagerModules hostname;
              };
            }
          ];
        };
    in
      lib.genAttrs ["tuxedo" "cuda"] mkHost;

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
}

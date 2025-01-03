{ inputs, ... }:
{
  flake.nixosConfigurations =
    let
      mkHost =
        hostname:
        inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs.inputs = inputs;
          ####################################################################
          specialArgs.pkgs =
            let
              system = "x86_64-linux";
              ts-nixpkgs = import inputs.nixpkgs-tree-sitter { system = "x86_64-linux"; };
              ts-overlay = final: prev: { inherit (ts-nixpkgs) tree-sitter; };
            in
            import inputs.nixpkgs {
              inherit system;
              config = {
                allowUnfree = true;
                permittedInsecurePackages = [ "olm-3.2.16" ];
              };
              overlays = [ ts-overlay ];
            };
          ####################################################################
          modules = [
            # The system configuration
            ../nixos/${hostname}

            # Home manager configuration
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.gaetan.imports = [ ../home/hosts/${hostname} ];
                extraSpecialArgs.inputs = inputs;
              };
            }
          ];
        };
    in
    {
      framework = mkHost "framework";
      cuda = mkHost "cuda";
      chamaeleon = mkHost "chamaeleon"; # inria
    };
}

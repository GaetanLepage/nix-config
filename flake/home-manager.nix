{
  inputs,
  homeManagerModules,
  ...
}: {
  _module.args = {
    homeManagerModules = hostname: [
      inputs.nix-index-database.hmModules.nix-index
      ../home/hosts/${hostname}
    ];
  };

  # Inria
  flake.homeConfigurations.inria = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        cudaSupport = true;
      };
    };
    extraSpecialArgs.inputs = inputs;
    modules = homeManagerModules "inria";
  };
}

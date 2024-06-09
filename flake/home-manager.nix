{
  inputs,
  homeManagerModules,
  ...
}: {
  _module.args = {
    homeManagerModules = hostname: [
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

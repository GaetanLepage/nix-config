{ inputs, config, ... }:
{
  flake.homeConfigurations.inria = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        cudaSupport = true;
      };
    };

    extraSpecialArgs.inputs = inputs;

    modules = with config.flake.modules.homeManager; [
      core
      host_inria
    ];
  };
}

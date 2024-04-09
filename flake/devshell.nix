{
  perSystem = {
    config,
    pkgs,
    system,
    ...
  }: {
    devShells.default = pkgs.mkShellNoCC {
      packages = builtins.attrValues config.packages;
    };
  };
}

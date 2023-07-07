{pkgs, ...}: {

  home = {
    packages = with pkgs; [
      nixpkgs-review
      alejandra
      statix
    ];

    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
  };
}

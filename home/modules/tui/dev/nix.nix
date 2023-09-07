{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      alejandra
      nix-init
      nix-update
      nix-output-monitor
      nixpkgs-review
      statix
    ];

    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
  };
}

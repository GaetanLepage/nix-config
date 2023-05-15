{
  nix.settings = {
    warn-dirty = false;
    experimental-features = "nix-command flakes";

    substituters = [
      "https://cache.nixos.org"
      "https://cache.nixos.org/"
      "https://cuda-maintainers.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };
}

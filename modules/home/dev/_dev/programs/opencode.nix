{ lib, ... }:
{
  programs.opencode = {
    enable = true;

    settings = {
      model = lib.mkDefault "anthropic/claude-opus-4-6";
      permission = {
        external_directory = {
          # /nix/store entries are world-readable (RO) anyway
          "/nix/store" = "allow";
        };
      };
    };
  };

  home.shellAliases.oc = "opencode";
}

{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    opencode-claude-auth
  ];

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

      plugin = [
        "opencode-claude-auth"
      ];
    };
  };

  home.shellAliases.oc = "opencode";
}

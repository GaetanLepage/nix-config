{
  flake.modules.homeManager.core =
    { pkgs, ... }:
    {
      programs = {
        nixvim = {
          extraPackages = with pkgs; [
            shellcheck
            shfmt
          ];
          lsp.servers.bashls.enable = true;
        };
      };
    };
}

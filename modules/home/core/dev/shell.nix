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
          plugins.lsp.servers.bashls.enable = true;
        };
      };
    };
}

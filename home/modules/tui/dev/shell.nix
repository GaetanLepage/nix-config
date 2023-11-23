{
  programs = {
    nixvim = {
      plugins = {
        efmls-configs.setup = let
          shellTools = {
            formatter = "shfmt";
            linter = "shellcheck";
          };
        in {
          bash = shellTools;
          sh = shellTools;
        };

        lsp.servers = {
          bashls.enable = true;

          efm.filetypes = [
            "bash"
            "sh"
          ];
        };
      };
    };
  };
}

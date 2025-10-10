{
  flake.modules.homeManager.core =
    {
      pkgs,
      config,
      ...
    }:
    {
      home = {
        packages = with pkgs; [
          cargo
          gcc
          rustc
          rustfmt
        ];

        # By default, it is in ~/.cargo
        sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";
      };

      programs = {
        bacon.enable = true;

        nixvim = {
          lsp.servers.rust_analyzer = {
            enable = true;
            config.settings = {
              cargo.features = "all";
            };
          };
        };
      };
    };
}

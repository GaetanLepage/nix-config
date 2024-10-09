{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      bacon
      cargo
      gcc
      rustc
      rustfmt
    ];

    # inria ?
    sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";
  };

  programs.nixvim = {
    plugins = {
      lsp-format.lspServersToEnable = ["rust_analyzer"];
      lsp.servers.rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
        settings = {
          cargo.features = "all";
        };
      };
    };
  };
}

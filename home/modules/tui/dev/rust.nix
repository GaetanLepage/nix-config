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
      plugins.lsp.servers.rust_analyzer = {
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

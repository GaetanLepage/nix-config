{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      cargo
      stdenv.cc.cc # GCC
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
}

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

    sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";
  };

  programs.nixvim = {
    plugins = {
      lsp-format.lspServersToEnable = ["rust-analyzer"];
      lsp.servers = {
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
          settings = {
            cargo.features = "all";
          };
        };
      };
    };
  };
}

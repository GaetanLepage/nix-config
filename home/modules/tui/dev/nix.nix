{
  pkgs,
  lib,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      alejandra
      nix-tree
      nix-output-monitor
      statix
      patchelf

      # nixpkgs
      nix-update
      nixpkgs-review
      nixfmt-rfc-style
      luarocks-packages-updater
      vimPluginsUpdater
    ];

    shellAliases = {
      cn = "cd ~/nix/nixpkgs";
      cnp = "cd ~/nix/nixpkgs-packages";

      nb = "nom-build --system x86_64-linux -A";
      nbl = "nom-build --system x86_64-linux --builders '' -A";
      nba = "nom-build --max-jobs 0 --system aarch64-linux -A";
      nbd = "nom-build --max-jobs 0 --system x86_64-darwin -A";
      nbda = "nom-build --max-jobs 0 --system aarch64-darwin -A";
      ur = "${lib.getExe pkgs.fd} --no-ignore --max-depth 1 'result*' --exec unlink";

      nr = "nixpkgs-review";

      nu = "nix-update";
      nuc = "nix-update --commit";
      nucb = "nix-update --commit --build";

      nrb = "nix-remote-build";
      nrba = "nix-remote-build arm";
      nrbd = "nix-remote-build darwin";
      nrbj = "nix-remote-build jrs";
      nrbl = "nix-remote-build linux-build-box";

      clean-reviews = "rm -rf ${config.xdg.cacheHome}/nixpkgs-review/*";
    };

    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs = {
    fish = {
      shellAbbrs = {
        nrv = "nixpkgs-review pr --no-shell --systems all --post-result";
      };

      functions = {
        cl = "ssh cuda $argv | wl-copy";

        nix-remote-build = ''
          nix-copy-closure --to $argv[1] $argv[2]

          ssh $argv[1] nom-build $argv[2..-1]
        '';
      };
    };

    nix-init = {
      enable = true;
      settings = {
        maintainers = [ "GaetanLepage" ];
      };
    };

    nixvim = {
      plugins.lsp.servers.nil_ls = {
        enable = true;
        settings.formatting.command = [
          (lib.getExe pkgs.nixfmt-rfc-style)
        ];
      };

      files."after/ftplugin/nix.lua" = {
        # Set indentation to 2 spaces
        localOpts = {
          tabstop = 2;
          shiftwidth = 2;
        };
      };
    };
  };
}

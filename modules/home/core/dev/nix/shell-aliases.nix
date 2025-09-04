{
  flake.modules.homeManager.core =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      home.shellAliases = {
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
        nrbp = "nix-remote-build paris";

        clean-reviews = "rm -rf ${config.xdg.cacheHome}/nixpkgs-review/*";
      };

      programs.fish = {
        shellAbbrs = {
          nrv = "nixpkgs-review pr --post-result";
        };

        functions = {
          cl = "ssh cuda $argv | wl-copy";

          nix-remote-build = ''
            nix-copy-closure --to $argv[1] $argv[2]

            ssh $argv[1] nom-build $argv[2..-1]
          '';
        };
      };
    };
}

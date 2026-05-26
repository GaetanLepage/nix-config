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

    nb = "nom-build -A";
    nbl = "nom-build --system x86_64-linux -A";
    nba = "nom-build --max-jobs 0 --system aarch64-linux -A";
    nbd = "nom-build --max-jobs 0 --system x86_64-darwin -A";
    nbda = "nom-build --max-jobs 0 --system aarch64-darwin -A";
    ur = "${lib.getExe pkgs.fd} --no-ignore --max-depth 1 'result*' --exec unlink";

    nct = "nix-copy-closure --to";
    ncf = "nix-copy-closure --from";

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

  programs.fish = {
    shellAbbrs = {
      nds = "nix derivation show";
      nl = "nix log";
      nrv = "nixpkgs-review pr --systems all";
      nbc = "nom-build --arg config '{ allowUnfree = true; cudaSupport = true; }' -A";
    };

    functions = {
      cl = "ssh cuda $argv | wl-copy";

      nix-remote-build = ''
        if test (count $argv) -lt 2
          echo "Usage: nix-remote-build <host> [extra args...] <drv>"
          return 1
        end

        set -l host $argv[1]
        set -l drv $argv[-1]
        set -l extra_args $argv[2..-2]

        # Step 1: Copy the derivation closure to the remote host
        echo "=> Copying closure to $host..."
        nix-copy-closure --to $host $drv
        or return 1

        # Step 2: Build on the remote host (nom-build with fallback to nix-build)
        set -l build_cmd nix-build
        if ssh $host command -v nom-build &>/dev/null
          set build_cmd nom-build
        end
        echo "=> Building $drv on $host..."
        ssh $host -t $build_cmd $extra_args $drv
        or return 1

        # Step 3: Fetch all output paths back
        for p in (nix-store -q --outputs $drv)
          echo "=> Fetching output $p from $host..."
          nix-copy-closure --from $host $p
          or return 1
        end
      '';
    };
  };
}

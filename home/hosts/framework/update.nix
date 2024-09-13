{
  pkgs,
  lib,
  ...
}: {
  home = let
    update =
      pkgs.writeShellScriptBin
      "update"
      ''
        # Path to the folder containing `flake.nix`
        nix_dir=$HOME/config

        # Update the flake's inputs
        nix flake update $nix_dir -L

        doas nixos-rebuild switch \
            --verbose \
            --fast \
            --flake $nix_dir \
            --builders ""
      '';
  in {
    shellAliases.u = lib.getExe update;
    packages = [update];
  };
}

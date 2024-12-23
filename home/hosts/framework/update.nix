{
  pkgs,
  lib,
  ...
}:
{
  home =
    let
      update = pkgs.writeShellScriptBin "update" ''
        # Path to the folder containing `flake.nix`
        nix_dir=$HOME/config

        # Update the flake's inputs
        nix flake update --flake $nix_dir -L

        # TODO: revert to original command when https://github.com/NixOS/nix/issues/10202 is fixed
        # doas nixos-rebuild switch \
        nixos-rebuild switch --use-remote-sudo \
            --verbose \
            --fast \
            --flake $nix_dir \
            --builders ""
      '';
    in
    {
      shellAliases.u = lib.getExe update;
      packages = [ update ];
    };
}

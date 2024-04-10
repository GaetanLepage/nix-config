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

        # Reload the system configuration
        case $1 in
            cuda)
                nixos-rebuild switch \
                    --fast \
                    --flake $nix_dir\#cuda \
                    --target-host root@cuda \
                    --build-host root@cuda
                ;;

            `hostname`|"")
                doas nixos-rebuild switch \
                    --verbose \
                    --flake $nix_dir \
                    --builders ""

                # Clean the store (garbage collection)
                # Also removes old generations
                # doas nix-collect-garbage --delete-older-than 2d
                ;;
        esac
      '';
  in {
    shellAliases.u = lib.getExe update;
    packages = [update];
  };
}

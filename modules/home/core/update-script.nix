{
  flake.modules.homeManager.update-script =
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

            if ! [ -d "$nix_dir" ]; then
              echo "ERROR: '$nix_dir' does not exist"
              exit 1
            fi

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
    };
}

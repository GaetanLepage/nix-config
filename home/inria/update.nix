{pkgs, ...}: {
  home.sessionPath = let
    updateScript =
      pkgs.writeShellScriptBin
      "update"
      ''
        set -e

        profile=$1

        flake_dir="$HOME/config"

        rm -f $flake_dir/flake.lock

        git -C $flake_dir pull

        nix flake update $flake_dir

        [ -f $XDG_CONFIG_HOME/user-dirs.dirs ] && rm $HOME/.config/user-dirs.dirs

        home-manager switch --flake $flake_dir\#$profile -v

        nix-collect-garbage --delete-older-than 2d
      '';

    updateScriptPath = "${toString updateScript}/bin";
  in [updateScriptPath];
}

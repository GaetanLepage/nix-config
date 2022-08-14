{ pkgs, lib, ... }:

{
    programs.zsh.initExtra = ''
        # define path to the exputils folder
        case "`hostname`" in

            alya|auriga|bacchus|chamaeleon|carina|access[1-2]-cp)
                PATH_TO_EXPUTILS=$HOME/scratch/exputils_sync/code/exputils
                ;;
            tuxedo)
                PATH_TO_EXPUTILS=$HOME/inria/code/exputils
                ;;
            *)
                echo "[EXPUTILS] Warning '`hostname`' is an unknown hostname."
                ;;
        esac

        if [ -f "$PATH_TO_EXPUTILS/commands/eu_setup.sh" ] ; then
            . "$PATH_TO_EXPUTILS/commands/eu_setup.sh" "$PATH_TO_EXPUTILS"
        fi
        # set default project for exputils commands
        export EU_DEFAULT_PRJ=rlan
        # activate the default project
        source eu_activate $EU_DEFAULT_PRJ
    '';

    home.shellAliases = {
        eupc = "eu_local_inria_push_code";
        euru = "eu_local_inria_run_experiments";
        eupd = "eu_local_inria_pull_data";
    };
}

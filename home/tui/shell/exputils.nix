{
  programs.zsh.initExtra = ''
    # define path to the exputils folder
    case "`hostname`" in

        alya|auriga|bacchus|chamaeleon|carina|access[1-2]-cp)
            PATH_TO_EXPUTILS=/scratch/alya/galepage/exputils_sync/exputils_commands
            ;;
        tuxedo)
            PATH_TO_EXPUTILS=$HOME/inria/code/exputils_commands
            ;;
    esac

    if [ -n "$PATH_TO_EXPUTILS" ]; then
      if [ -f "$PATH_TO_EXPUTILS/commands/eu_setup.sh" ]; then
        . "$PATH_TO_EXPUTILS/commands/eu_setup.sh" "$PATH_TO_EXPUTILS"
      fi

      # set default project for exputils commands
      export EU_DEFAULT_PRJ=rlan

      # activate the default project
      source eu_activate $EU_DEFAULT_PRJ
    fi
  '';

  home.shellAliases = {
    eupc = "eu_local_inria_push_code";
    eure = "eu_local_inria_run_experiments";
    eugs = "eu_local_inria_get_status";
    eupd = "eu_local_inria_pull_data";
  };
}

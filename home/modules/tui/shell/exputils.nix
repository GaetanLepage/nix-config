{
  programs.fish.shellInit = ''
    # define path to the exputils folder
    switch $(hostname)
      case alya auriga bacchus carina access[1-2]-cp
        set -gx PATH_TO_EXPUTILS /scratch/alya/galepage/exputils_sync/exputils_commands
      case framework
        set -gx PATH_TO_EXPUTILS $HOME/inria/code/exputils_commands
    end

    if [ -n "$PATH_TO_EXPUTILS" ]
      if [ -f "$PATH_TO_EXPUTILS/commands/eu_setup.sh" ]
        bass source "$PATH_TO_EXPUTILS/commands/eu_setup.sh" "$PATH_TO_EXPUTILS"
      end

      # set default project for exputils commands
      set -gx EU_DEFAULT_PRJ rlan

      # activate the default project
      bass source eu_activate $EU_DEFAULT_PRJ
    end
  '';

  home.shellAliases = {
    eupc = "eu_local_inria_push_code";
    eure = "eu_local_inria_run_experiments";
    eugs = "eu_local_inria_get_status";
    eupd = "eu_local_inria_pull_data";
  };
}

{
  flake.modules.homeManager.core = {
    # SSH keyring
    services.ssh-agent.enable = true;
    home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
  };
}

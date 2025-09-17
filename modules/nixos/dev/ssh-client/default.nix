{
  flake.modules.nixos.ssh-client = {
    # Start the OpenSSH agent when you log in.
    # The OpenSSH agent remembers private keys for you so that you don’t have to type in passphrases
    # every time you make an SSH connection.
    # Use ssh-add to add a key to the agent.
    programs.ssh.startAgent = true;
  };
}

{
  services.openssh = {
    enable = true;

    settings.PasswordAuthentication = false;
  };

  users.users =
    let
      persoKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEJSonNBBb1DlhaO4EfMh3TbIIsV25phZQ9vp/qKOw9E";
    in
    {
      gaetan.openssh.authorizedKeys.keys = [ persoKey ];
      root.openssh.authorizedKeys.keys = [ persoKey ];
    };

  imports = [
    ./keys
  ];

  # Start the OpenSSH agent when you log in.
  # The OpenSSH agent remembers private keys for you so that you don’t have to type in passphrases
  # every time you make an SSH connection.
  # Use ssh-add to add a key to the agent.
  programs.ssh.startAgent = true;
}

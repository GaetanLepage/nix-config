{
  services.openssh = {
    enable = true;

    settings.PasswordAuthentication = false;
  };

  users.users = let
    laptopRsaKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDu/0hQmxRaySjFSH3EmK6CfTjuUBBahBjN875Dn81ZyiR9wQxkeKEx1zar5wjEK3yvFBhHzAxE1BlA0QyEkEnAhdO55IKtRAGOKtvrMimF0RmqTFZYR6kMh91y5CWF23F3On//k+t5ci63ViwHwaLehK+ulrupv3Uf1Wo0hpxngh0g9GVBDQrmiWKATyLefdAAS5wTTRAhk6Cd/j0Gp2P4P3YehM6f75OFbpU8abnQKMaaDITHLaAKE2fbA+c8SdsSoNQJnIoiaH2wurKZs7WSy+DUlRRFVmAJKYpkIQoFc6Y2c9boQg/jrD9vib81kISC3ptjadaGSlwCUhZBKGp0u06OsyjeCziR5682UhmVDsw6AOlkShvK6bRElU8lPpN9LGGxg9jaiUBfaRGV5BKUK3Zrv9/51CCJMAmfu/rFttQ5CXS0tTpbjhm1l/8BPLX9ur47YddhYa+M//RTt+aEJse2C7VfuB/reCrpboHwhSjEoihSb0msqVung2FZW/0= gaetan@gaetan-xps";
  in {
    gaetan.openssh.authorizedKeys.keys = [laptopRsaKey];
    root.openssh.authorizedKeys.keys = [laptopRsaKey];
  };

  # Start the OpenSSH agent when you log in.
  # The OpenSSH agent remembers private keys for you so that you don’t have to type in passphrases
  # every time you make an SSH connection.
  # Use ssh-add to add a key to the agent.
  programs.ssh.startAgent = true;
}

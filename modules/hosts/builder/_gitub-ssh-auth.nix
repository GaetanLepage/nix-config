# ssh-perso key is not available on this builder -> Use a passphrase-protected key for GitHub only

{ config, ... }:
{
  services.ssh-agent.enable = true;
  programs.ssh.matchBlocks."github.com".identityFile = config.age.secrets.ssh-github.path;

  # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3pKoSya7AukHN9XjglUutnbEvZ1sx1RHOV8CaKy+vi
  age.secrets.ssh-github.rekeyFile = ./ssh-github.age;
}

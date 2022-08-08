{ ... }:

{
    # Define a user account. Don't forget to set a password with ‘passwd’.
    # TODO Make users imutable
    users = {
        users.gaetan = {
            isNormalUser = true;
            group = "gaetan";

            extraGroups = [
                "wheel"             # Enable ‘sudo’ for the user.
                "networkmanager"    # Enable user to add and edit network connections
            ];
            initialPassword = "password";
            shell = pkgs.zsh;
        };

        groups.gaetan.gid = 1000;
    };
}

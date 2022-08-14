{ pkgs, ... }:

{
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users = {
        mutableUsers = false;

        users = {

            root = {
                isSystemUser = true;

                hashedPassword = "$6$YYNv6Qj1MvlIYyU0$tMh0jZ69NXyDJJhbOqJPi6QOwPHvACPSMcPaycLsn8CiZwxdomX441rBX4jPL2lAPUkDW1wn2f9yiiguE3ZV6.";
            };

            gaetan = {
                isNormalUser = true;
                uid = 1000;

                group = "gaetan";

                extraGroups = [
                    "wheel"             # Enable ‘sudo’ for the user.
                    "networkmanager"    # Enable user to add and edit network connections
                ];

                hashedPassword = "$6$B8kfsZOV58EoH14x$BfGmC7pgPCUj60hlvjVEOpoynbiF4mezwZe9WF3R9U45lAPlrsBW0QdDOBMoJfP58i7Dr3idq0mV95UG0Uxuv.";

                shell = pkgs.zsh;
            };
        };

        groups.gaetan.gid = 1000;
    };
}

{
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
          # Enable ‘sudo’ for the user.
          "wheel"

          # Enable user to add and edit network connections
          "networkmanager"

          "lepage"
        ];

        hashedPassword = "$6$B8kfsZOV58EoH14x$BfGmC7pgPCUj60hlvjVEOpoynbiF4mezwZe9WF3R9U45lAPlrsBW0QdDOBMoJfP58i7Dr3idq0mV95UG0Uxuv.";
      };
    };

    groups = {
      gaetan.gid = 1000;

      # To be able to access folders owned by 'lepage' on the server
      lepage.gid = 1005;
    };
  };
}

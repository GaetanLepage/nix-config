{
  flake.modules.darwin.core =
    { primaryUser, ... }:
    {
      users.users.${primaryUser}.home = "/Users/${primaryUser}";
    };
}

{
  flake.modules.nixos.android =
    { pkgs, primaryUser, ... }:
    {
      environment.systemPackages = with pkgs; [
        android-tools
      ];

      users.users.${primaryUser}.extraGroups = [ "adbusers" ];
    };
}

{ pkgs, ... }:

{
    programs.adb.enable = true;

    users.users.gaetan.extraGroups = ["adbusers"];

    # environment.systemPackages = with pkgs; [
    #     libwacom
    #     xf86_input_wacom
    # ];
}

{
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 4;
    };

    efi.canTouchEfiVariables = true;

    timeout = 0;

    grub.enable = false;
  };
}

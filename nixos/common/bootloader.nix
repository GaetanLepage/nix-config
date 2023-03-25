{
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };

    efi.canTouchEfiVariables = true;

    timeout = 0;

    grub.enable = false;
  };
}

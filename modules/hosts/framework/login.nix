{
  flake.modules.nixos.host_framework =
    { config, ... }:
    {

      services = {
        # Enable fingerprint sensor
        fprintd.enable = true;
      };

      # Enable fingerprint authentification for swaylock
      security.pam.services.swaylock = {
        enable = true;

        # Using `fprintAuth = true` does not allow password-only unlocking
        text = ''
          auth sufficient pam_unix.so
          auth sufficient ${config.services.fprintd.package}/lib/security/pam_fprintd.so
          auth required pam_deny.so
        '';
      };

      # Disable fingerprint authentification for SDDM (display manager)
      # If enable, both password AND fingerprints are required
      security.pam.services.login.fprintAuth = false;
    };
}

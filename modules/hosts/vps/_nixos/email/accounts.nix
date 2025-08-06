let
  # To generate the password hash:
  # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'

  domain = "glepage.com";
in
{
  "gaetan@${domain}" = {
    hashedPassword = "$2b$05$ypXOSOtY8tOzh1c6/G.lkesf9NaiHHFiUi0ZbC/gk1wWlcGtyRCrS";
    aliases = [
      "postmaster@${domain}"
      "3iTYog@${domain}"
      "pub@${domain}"

      "gaetan-medium@${domain}"
      "gaetan-twitter-public@${domain}" # @GaetanLepage_
    ];
  };

  # GitHub notifications & co
  "dev@${domain}".hashedPassword = "$2b$05$WSWCiow5WoKz6KbeYM2kDu9up1bs743gqZlt75K.eIkIvWf7.BUDO";

  "backup-tank@${domain}".hashedPassword =
    "$2b$05$4tevC0VlFz25.MbqUJj9IOS0fTuK6FwCoG4SEYosN9hDFiILHaXCS";

  "nextcloud@${domain}".hashedPassword =
    "$2b$05$kM8SVZdLQQcDtKlV4esnnO.Dhs7slPpSn2269fDB4oh6jIDcvWzMy";

  ################################
  # Aliases for deleted accounts #
  ################################
  "gaetan-inp-org@${domain}".hashedPassword =
    "$2b$05$WYcyz0ouNQersRO2M8vfNO3xK3g3p0HPYPJrGwWOMx/CImiDtIvnu";

  "gaetan-inp-fr@${domain}".hashedPassword =
    "$2b$05$kkIjgZQNey4GT9wtkcL53OjuwXS7gG/fJ586w3vzCEvhPt38WVbOq";

  "gaetan-lepage-knives@${domain}".hashedPassword =
    "$2b$05$P.hQu3fexLTdofF7KP97wuLf.aG81ChHsiXj43l9rYuQABaC5GrD.";

  ###########
  # Famileo #
  ###########
  "thierry.famileo@${domain}".hashedPassword =
    "$2b$05$p.DRno51jAtjNIxkh47t8Oh9DdhCR2pWBhhjVyDy0X1Z5h78VYmwm";

  "francoise.famileo@${domain}".hashedPassword =
    "$2b$05$Gww22I/3wTjPzY/f9QzdDeFL/0SgCX8po34QEweP3FRf2dFrRPbVO";
}

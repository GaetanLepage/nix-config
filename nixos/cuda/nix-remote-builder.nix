{
  users.users.nix = {
    isNormalUser = true;
    group = "nix";

    openssh.authorizedKeys.keys = [
      # root@alya (for nix builds)
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCgwMyuCFetbU3ppyQLW0sAN7IlAUu6lKIuL/XetfqVjC8mREuqGOiEkEdcFgSipeSSbyoNx5BspsqgnYDqIkXLAWJrFJI2QZr8vsSMeFwF0PZIdCXMp+61pSkzgsJbn18wZkkJ/jyDv83GZRFbv88wghrtrnJoPZici96nGb/11R35Jup+cQcCAN+TQFDaZDGlOc195yoT9HmmVLIjTFiVikCSzWveKOkqzXtOUiYCVhr+8QPEB2inTH7fMrqKMFKTb59tZT9pYT1wLgFuIyqQxm9Cf3sZuyugS+xYdkxkKfdwl/bP2GSn3mz2ZEcqxX7bBOKKOlv8eeUKJyoVf50ILVG5debcCZ8jwtU3UsbMfzYj6E8BOO+x8W+iSTMN86KHNIJy2/PPltT0wThxyJqjPoo9Bl/CtzOxSI1jVeXrlu8ckHr/ru3+wQk/i2/Bt1l7W27lqURSBC5vxuqcFPKMtaJ2MQ0rG4KDnzXzncRU6y9SXSvn+e3Wk47nc1eyJaE= root@alya"
    ];
  };

  nix.settings.trusted-users = ["nix"];
}

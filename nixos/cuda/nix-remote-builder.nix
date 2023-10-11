{
  users = {
    users.nix = {
      isNormalUser = true;
      group = "nix";

      openssh.authorizedKeys.keys = [
        # root@alya (for nix builds)
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCgwMyuCFetbU3ppyQLW0sAN7IlAUu6lKIuL/XetfqVjC8mREuqGOiEkEdcFgSipeSSbyoNx5BspsqgnYDqIkXLAWJrFJI2QZr8vsSMeFwF0PZIdCXMp+61pSkzgsJbn18wZkkJ/jyDv83GZRFbv88wghrtrnJoPZici96nGb/11R35Jup+cQcCAN+TQFDaZDGlOc195yoT9HmmVLIjTFiVikCSzWveKOkqzXtOUiYCVhr+8QPEB2inTH7fMrqKMFKTb59tZT9pYT1wLgFuIyqQxm9Cf3sZuyugS+xYdkxkKfdwl/bP2GSn3mz2ZEcqxX7bBOKKOlv8eeUKJyoVf50ILVG5debcCZ8jwtU3UsbMfzYj6E8BOO+x8W+iSTMN86KHNIJy2/PPltT0wThxyJqjPoo9Bl/CtzOxSI1jVeXrlu8ckHr/ru3+wQk/i2/Bt1l7W27lqURSBC5vxuqcFPKMtaJ2MQ0rG4KDnzXzncRU6y9SXSvn+e3Wk47nc1eyJaE= root@alya"

        # root@tuxedo (for nix builds)
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuUjKg5MPTBG/EWoek0AwdZYXUSkGk8XLkuGUReDKPUMt8KDMRL9KuR9/c3PXKiPaRsJHsXdAQeBH5gmLIka0NHf3RYIkSXIv6hcsq6QB+gnZ21Y8dnrBKP1RpHxkbJqBOjqoBcjIGSz7MJkOwVpDpzAfpcea15iBhLFQtWcrrmj9RrJV7Jqt1KuxnCsNWt9GTmm9UEKIF402afKWbfwJEb2KWuczGnKL7GzvVbj/wBxzKucjky8o6PdbzoSmOfhP8HrmZuyPcxVWVA2dHGPOGgkx8SKnei3j1+LBAA5NjvmZUCwuB5KYq5PmHmCwHQyuPdjL/k+A/IGht1lKyruB/AzPM5kDU8cxp6YyowQqlTfy85LBXdH8WFQ6tFIkb5bk9qk/RH6vvpEhxuBPiFnnlT+mf7TUflymx+rfHPax94a+MGjtWWbIwLfPePEWH60YfBBWDA5tNaBhXBTX4sNucE5Saw+Ah59mg8k248Csz/OL1oTJ5UTyfSZhvP1iRWCk= root@tuxedo"
      ];
    };
    groups.nix = {};
  };

  nix.settings.trusted-users = ["nix"];
}

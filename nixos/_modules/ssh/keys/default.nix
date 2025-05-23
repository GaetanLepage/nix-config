{ lib, ... }:
{
  age.secrets =
    with lib;
    listToAttrs (
      map
        (
          keyName:
          nameValuePair "ssh-${keyName}" {
            rekeyFile = ./${keyName}.age;
            owner = "gaetan";
            mode = "600";
          }
        )
        [
          # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB9rFi0TNWY+VAcDvG5xg3l4gNHp8at8r7mvanClWuj9
          "gricad" # inria

          # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPK93KfprlwjY7soWarL9CVH36EdH6ceGtAZv7uJvF/Z
          "inria" # inria

          # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEJSonNBBb1DlhaO4EfMh3TbIIsV25phZQ9vp/qKOw9E
          "perso"

          # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAQCM25FgJo9CvSn2tNzmpBvuaK7LruFitUog7+SSPAP
          "jonringer-server"

          # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJfOUACs5oAn4Hyt6uMM5e/Xux0/5ODvSeg5zOy4MY1b
          "liberodark-builder"
        ]
    );
}

{ lib, ... }:
{
  age.secrets = lib.listToAttrs (
    map
      (
        keyName:
        lib.nameValuePair "ssh-${keyName}" {
          rekeyFile = ./${keyName}.age;
          mode = "600";
        }
      )
      [
        # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEJSonNBBb1DlhaO4EfMh3TbIIsV25phZQ9vp/qKOw9E
        "perso"

        # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAQCM25FgJo9CvSn2tNzmpBvuaK7LruFitUog7+SSPAP
        "jonringer-server"
      ]
  );
}

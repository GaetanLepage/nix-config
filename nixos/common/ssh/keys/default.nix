{lib, ...}: {
  age.secrets = with lib;
    listToAttrs (
      map (keyName:
        nameValuePair "ssh-${keyName}" {
          rekeyFile = ./${keyName}.age;
          owner = "gaetan";
          mode = "600";
        })
      [
        "gricad"
        "inria"
        "lepage-knives"
        "perso"
      ]
    );
}

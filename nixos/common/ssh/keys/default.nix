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
        "gricad" # inria
        "inria" # inria
        "lepage-knives"
        "perso"
        "jonringer-server"
      ]
    );
}

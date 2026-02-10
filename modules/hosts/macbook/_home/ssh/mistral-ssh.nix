{ lib, config, ... }:
let
  cfg = config.mistral.ssh;

  inherit (lib) mkEnableOption mkOption types;
  getLoginPodName = import ./get-login-pod-name.nix { inherit lib; };
in
{
  options.mistral.ssh = {
    enable = mkEnableOption "";

    username = mkOption {
      type = types.str;
    };

    podHostname = mkOption {
      type = types.str;
      default = getLoginPodName cfg.username;
    };

    clusters = mkOption {
      type =
        let
          clusterType = types.submodule (
            { name, config, ... }:
            {
              options = {
                clusterPrefix = mkOption {
                  type = types.str;
                  default = "${name}*";
                };
                numNodes = mkOption {
                  type = types.ints.unsigned;
                };
                nodeHost = mkOption {
                  type = with types; functionTo str;
                  default = nodeId: "${name}${nodeId}";
                };
                nodeHostname = mkOption {
                  type = with types; functionTo str;
                };
              };
            }
          );
        in
        types.attrsOf clusterType;
    };
  };

  config =
    let
      inherit (config.home) homeDirectory;
      secretiveSocket = "${homeDirectory}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
    in
    lib.mkIf cfg.enable {

      home.sessionVariables =
        let
          locale = "en_US.UTF-8";
        in
        {
          LC_ALL = locale;
          LANG = locale;
          LANGUAGE = locale;
          SSH_AUTH_SOCK = secretiveSocket;
        };

      programs.ssh.matchBlocks =
        let

          mkClusterHosts =
            clusterName: clusterOpts:
            let
              clusterNodes = builtins.genList (
                nodeIdInt:
                let
                  nodeId = toString nodeIdInt;
                in
                {
                  name = clusterOpts.nodeHost nodeId;
                  value.hostname = clusterOpts.nodeHostname nodeId;
                }
              ) clusterOpts.numNodes;

              individualLoginPod = {
                name = clusterName;
                value.hostname = clusterOpts.nodeHostname "${cfg.podHostname}-0";
              };

            in
            clusterNodes
            ++ [
              individualLoginPod
            ];

          # extractClusterPrefix = clusterName: clusterOpts: clusterOpts.clusterPrefix or "${clusterName}*";
          allClusterPrefixes = lib.mapAttrsToList (_: builtins.getAttr "clusterPrefix") cfg.clusters;

          commonMatch = lib.singleton {
            name = builtins.concatStringsSep " " allClusterPrefixes;
            value = {
              user = cfg.username;

              controlMaster = "auto";
              controlPath = "${homeDirectory}/.ssh/sockets/%C";
              controlPersist = "600";
              serverAliveInterval = 30;
              serverAliveCountMax = 15;
              forwardAgent = true;
              identityAgent = secretiveSocket;
              setEnv.TERM = "xterm-256color";
            };
          };

          clusterHostList = lib.concatLists (lib.mapAttrsToList mkClusterHosts cfg.clusters);
          clusterHostAttrs = lib.listToAttrs (commonMatch ++ clusterHostList);
        in
        clusterHostAttrs;
    };
}

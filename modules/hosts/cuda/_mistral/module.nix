{
  config,
  lib,
  pkgs,
  utils,
  ...
}:
let
  inherit (lib) literalExpression types getExe;
  inherit (utils) escapeSystemdExecArgs;

  cfg = config.services.mistral-rs;
  mistralrsPackage = cfg.package.override { inherit (cfg) acceleration; };

  staticUser = cfg.user != null && cfg.group != null;
in
{
  options = {
    services.mistral-rs = {
      enable = lib.mkEnableOption "mistral.rs server for local large language models";
      package = lib.mkPackageOption pkgs "mistral-rs" { };

      user = lib.mkOption {
        type = with types; nullOr str;
        default = null;
        example = "mistral-rs";
        description = ''
          User account under which to run mistral.rs. Defaults to [`DynamicUser`](https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#DynamicUser=)
          when set to `null`.

          The user will automatically be created, if this option is set to a non-null value.
        '';
      };
      group = lib.mkOption {
        type = with types; nullOr str;
        default = cfg.user;
        defaultText = literalExpression "config.services.mistral-rs.user";
        example = "mistral-rs";
        description = ''
          Group under which to run mistral.rs. Only used when `services.mistral-rs.user` is set.

          The group will automatically be created, if this option is set to a non-null value.
        '';
      };

      acceleration = lib.mkOption {
        type = types.nullOr (
          types.enum [
            false
            "cuda"
            "mkl"
          ]
        );
        default = null;
        example = "cuda";
        description = ''
          What interface to use for hardware acceleration.

          - `null`: default behavior
            - if `nixpkgs.config.cudaSupport` is enabled, uses `"cuda"`
            - otherwise defaults to `false`
          - `false`: disable GPU, only use CPU
          - `"cuda"`: supported by most modern NVIDIA GPUs
        '';
      };

      # TODO
      home = lib.mkOption {
        type = types.str;
        default = "/var/lib/mistral-rs";
        example = "/home/foo";
        description = ''
          The home directory that the mistral.rs service is started in.
        '';
      };
      models = lib.mkOption {
        type = types.str;
        default = "${cfg.home}/models";
        defaultText = "\${config.services.mistral-rs.home}/models";
        example = "/path/to/mistral-rs/models";
        description = ''
          The directory that the mistral-rs service will read models from and download new models to.
        '';
      };

      host = lib.mkOption {
        type = types.str;
        default = "127.0.0.1";
        example = "[::]";
        description = ''
          The host address which the mistral.rs server HTTP interface listens to.
        '';
      };

      port = lib.mkOption {
        type = types.port;
        default = 1234;
        example = 11111;
        description = ''
          Which port the mistral.rs server listens to.
        '';
      };

      command = lib.mkOption {
        type = types.str;
        default = "plain";
        example = "toml";
        description = ''
          Which type of model to load.
          This allows to use a derivative model (selecting the quantization or the tokenization).
          See https://github.com/EricLBuehler/mistral.rs?tab=readme-ov-file#using-derivative-model for more details.
        '';
      };

      extraFlags = lib.mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [
          "--log"
          "/var/log/mistral-rs.log"
          "--no-kv-cache"
        ];
        description = ''
          Extra commandline options to pass to the mistralrs-server program.
        '';
      };

      extraCommandFlags = lib.mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [
          "--model-id"
          "meta-llama/Meta-Llama-3.1-8B-Instruct"
          "--arch"
          "llama"
        ];
        description = ''
          Extra commandline options to pass to the mistralrs-server program.
        '';
      };

      # environmentVariables = lib.mkOption {
      #   type = types.attrsOf types.str;
      #   default = {};
      #   example = {
      #     OLLAMA_LLM_LIBRARY = "cpu";
      #     HIP_VISIBLE_DEVICES = "0,1";
      #   };
      #   description = ''
      #     Set arbitrary environment variables for the ollama service.
      #
      #     Be aware that these are only seen by the ollama server (systemd service),
      #     not normal invocations like `ollama run`.
      #     Since `ollama run` is mostly a shell around the ollama server, this is usually sufficient.
      #   '';
      # };
      # loadModels = lib.mkOption {
      #   type = types.listOf types.str;
      #   default = [];
      #   description = ''
      #     Download these models using `ollama pull` as soon as `ollama.service` has started.
      #
      #     This creates a systemd unit `ollama-model-loader.service`.
      #
      #     Search for models of your choice from: https://ollama.com/library
      #   '';
      # };

      openFirewall = lib.mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to open the firewall for mistral.rs.

          This adds `services.mistral-rs.port` to `networking.firewall.allowedTCPPorts`.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users = lib.mkIf staticUser {
      users.${cfg.user} = {
        inherit (cfg) home;
        isSystemUser = true;
        group = cfg.group;
      };
      groups.${cfg.group} = { };
    };

    systemd.services.mistral-rs = {
      description = "Server for local large language models";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      # environment =
      #   cfg.environmentVariables
      #   // {
      #     HOME = cfg.home;
      #     OLLAMA_MODELS = cfg.models;
      #     OLLAMA_HOST = "${cfg.host}:${toString cfg.port}";
      #   };
      # // lib.optionalAttrs (cfg.rocmOverrideGfx != null) {
      #   HSA_OVERRIDE_GFX_VERSION = cfg.rocmOverrideGfx;
      # };
      serviceConfig =
        lib.optionalAttrs staticUser {
          User = cfg.user;
          Group = cfg.group;
        }
        // {
          Type = "exec";
          DynamicUser = true;
          # ExecStartPre = "${pkgs.coreutils}/bin/cat /tmp/token";
          ExecStart = escapeSystemdExecArgs (
            [
              (getExe mistralrsPackage)
              "--serve-ip"
              cfg.host
              "--port"
              (toString cfg.port)
            ]
            ++ cfg.extraFlags
            ++ [
              cfg.command
            ]
            # ++ optionals (cfg.configFile != null) [
            #   "--config-file"
            #   cfg.configFile
            # ]
            ++ cfg.extraCommandFlags
          );
          WorkingDirectory = cfg.home; # TODO
          StateDirectory = [ "mistral-rs" ]; # TODO
          BindReadOnlyPaths = [
            "-/tmp"
          ];
          ReadWritePaths = [
            # TODO
            cfg.home
            cfg.models
            # "/tmp"
          ];

          # CapabilityBoundingSet = [""];
          # DeviceAllow = [
          #   # CUDA
          #   # https://docs.nvidia.com/dgx/pdf/dgx-os-5-user-guide.pdf
          #   "char-nvidiactl"
          #   "char-nvidia-caps"
          #   "char-nvidia-frontend"
          #   "char-nvidia-uvm"
          # ];
          # DevicePolicy = "closed";
          # LockPersonality = true;
          # MemoryDenyWriteExecute = true;
          # NoNewPrivileges = true;
          # PrivateDevices = false; # hides acceleration devices
          # PrivateTmp = true;
          # PrivateUsers = true;
          # ProcSubset = "all"; # /proc/meminfo
          # ProtectClock = true;
          # ProtectControlGroups = true;
          # ProtectHome = true;
          # ProtectHostname = true;
          # ProtectKernelLogs = true;
          # ProtectKernelModules = true;
          # ProtectKernelTunables = true;
          # ProtectProc = "invisible";
          # ProtectSystem = "strict";
          # RemoveIPC = true;
          # RestrictNamespaces = true;
          # RestrictRealtime = true;
          # RestrictSUIDSGID = true;
          # RestrictAddressFamilies = [
          #   "AF_INET"
          #   "AF_INET6"
          #   "AF_UNIX"
          # ];
          # SystemCallArchitectures = "native";
          # SystemCallFilter = [
          #   "@system-service @resources"
          #   "~@privileged"
          # ];
          # UMask = "0077";
        };
    };

    # systemd.services.ollama-model-loader = lib.mkIf (cfg.loadModels != []) {
    #   description = "Download ollama models in the background";
    #   wantedBy = [
    #     "multi-user.target"
    #     "ollama.service"
    #   ];
    #   after = ["ollama.service"];
    #   bindsTo = ["ollama.service"];
    #   environment = config.systemd.services.ollama.environment;
    #   serviceConfig = {
    #     Type = "exec";
    #     DynamicUser = true;
    #     Restart = "on-failure";
    #     # bounded exponential backoff
    #     RestartSec = "1s";
    #     RestartMaxDelaySec = "2h";
    #     RestartSteps = "10";
    #   };
    #
    #   script = ''
    #     total=${toString (builtins.length cfg.loadModels)}
    #     failed=0
    #
    #     for model in ${lib.escapeShellArgs cfg.loadModels}; do
    #       '${lib.getExe mistralrsPackage}' pull "$model" &
    #     done
    #
    #     for job in $(jobs -p); do
    #       set +e
    #       wait $job
    #       exit_code=$?
    #       set -e
    #
    #       if [ $exit_code != 0 ]; then
    #         failed=$((failed + 1))
    #       fi
    #     done
    #
    #     if [ $failed != 0 ]; then
    #       echo "error: $failed out of $total attempted model downloads failed" >&2
    #       exit 1
    #     fi
    #   '';
    # };

    networking.firewall = lib.mkIf cfg.openFirewall { allowedTCPPorts = [ cfg.port ]; };

    environment.systemPackages = [ mistralrsPackage ];
  };

  meta.maintainers = with lib.maintainers; [
    GaetanLepage
  ];
}

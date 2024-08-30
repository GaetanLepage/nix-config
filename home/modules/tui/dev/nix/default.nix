{
  pkgs,
  lib,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      alejandra
      nix-init
      nix-tree
      nix-output-monitor
      statix

      # nixpkgs
      nix-update
      nixpkgs-review
      nixfmt-rfc-style
      luarocks-packages-updater
      vimPluginsUpdater
      (pkgs.writeShellApplication {
        name = "nixpkgs-review-tmux";
        text = builtins.readFile ./review.sh;
        runtimeInputs = with pkgs; [
          nixpkgs-review
          tmux
        ];
      })
    ];

    shellAliases = {
      nb = "nom-build --system x86_64-linux -A";
      nbl = "nom-build --system x86_64-linux --builders '' -A";
      nba = "nom-build --max-jobs 0 --system aarch64-linux -A";
      nbd = "nom-build --max-jobs 0 --system x86_64-darwin -A";
      nbda = "nom-build --max-jobs 0 --system aarch64-darwin -A";
      ur = "unlink result";

      nr = "nixpkgs-review pr --post-result --no-shell";
      nra = "nixpkgs-review pr --post-result --no-shell --system aarch64-linux";
      nrd = "nixpkgs-review pr --post-result --no-shell --system x86_64-darwin";
      nrda = "nixpkgs-review pr --post-result --no-shell --system aarch64-darwin";

      nrt = "nixpkgs-review-tmux";

      nu = "nix-update";
      nuc = "nix-update --commit";
      nucb = "nix-update --commit --build";

      clean-reviews = "rm -rf ${config.xdg.cacheHome}/nixpkgs-review";
    };

    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs.nixvim = {
    extraConfigLuaPre = let
      nixfmtPath = lib.getExe pkgs.nixfmt-rfc-style;
      alejandraPath = lib.getExe pkgs.alejandra;
    in ''
      local get_nix_formatter = function()
        local match = function(name)
          return string.find(
            vim.fn.getcwd() .. "/",
            "/" .. name .. "/"
          )
        end

        -- remove when nixpkgs will have formatted the code base
        if match("nixpkgs") then
          return ""
        end

        if match("nixpkgs") or match("nixvim") then
          return "${nixfmtPath}"
        end

        return "${alejandraPath}"
      end
    '';

    plugins = {
      lsp.servers.nil-ls = {
        enable = true;
        settings.formatting.command = [{__raw = "get_nix_formatter()";}];
      };
      lsp-format.lspServersToEnable = ["nil-ls"];
    };

    # Set indentation to 2 spaces
    files."after/ftplugin/nix.lua" = {
      keymaps = [
        {
          key = "<leader>f";
          action = "<cmd>!nixfmt %<CR>";
          options.silent = true;
        }
      ];
      localOpts = {
        tabstop = 2;
        shiftwidth = 2;
      };
    };
  };
}

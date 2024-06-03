{pkgs, ...}: {
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
    };

    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs.nixvim = {
    plugins.lsp.servers.nil-ls.enable = true;

    # Set indentation to 2 spaces
    files."after/ftplugin/nix.lua" = {
      localOpts = {
        tabstop = 2;
        shiftwidth = 2;
      };
    };

    autoCmd = [
      {
        event = "BufWritePost";
        pattern = "*.nix";
        callback.__raw = ''
          function()
            -- No formatting in nixpkgs
            local file_absolute_path = vim.fn.expand('%:p')
            if string.find(file_absolute_path, "/nixpkgs/") then
              return
            end

            vim.fn.jobstart(
              {"nix", "fmt"},
              {
                stderr_buffered = true,

                on_stderr=function(_, data)
                  if data then
                    for _, line in ipairs(data) do
                      -- Ignore cases where formatting is not possible
                      if string.find(line, "error: could not find a flake.nix file") then
                        return
                      end
                      if string.find(line, "does not provide attribute") then
                        return
                      end
                    end
                    print("nix fmt: error!")
                  end
                end,

                on_exit=function(_, exit_code, _)
                  -- Refresh the file
                  vim.api.nvim_command("checktime")

                  -- Formatting was succesful
                  if exit_code == 0 then
                    print("nix fmt: OK")
                  end
                end
              }
            )
          end
        '';
      }
    ];
  };
}

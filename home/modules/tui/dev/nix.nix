{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      alejandra
      nix-init
      nix-tree
      nix-update
      nix-output-monitor
      nixpkgs-review
      statix
      vimPluginsUpdater
    ];

    shellAliases = {
      "nb" = "nom-build --system x86_64-linux -A";
      "nba" = "nom-build --system aarch64-linux -A";
      "nbd" = "nom-build --system x86_64-darwin -A";
      "nbda" = "nom-build --system aarch64-darwin -A";
    };

    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs.nixvim.autoCmd = [
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
}

{ lib, config, ... }:
{
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings.profiler.enabled = true;
    };

    extraConfigLuaPre =
      let
        nixvim_cfg = config.programs.nixvim;
      in
      lib.mkOrder 1 (
        lib.optionalString nixvim_cfg.plugins.snacks.settings.profiler.enabled # Lua
          ''
            -- if vim.env.PROF then
            if vim.env.PROF then
              local snacks = "${nixvim_cfg.plugins.snacks.package}"
              vim.opt.rtp:append(snacks)
              require("snacks.profiler").startup({
                startup = {
                  -- event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
                  event = "UIEnter",
                  -- event = "VeryLazy",
                },
              })
            end
          ''
      );
  };
}

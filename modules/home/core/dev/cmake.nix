{
  flake.modules.homeManager.core =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        cmake
        gnumake
      ];

      programs.nixvim = {
        plugins = {
          lsp-format.settings.cmake.exclude = [ "cmake" ];
          lsp.servers.cmake.enable = true;
        };
      };
    };
}

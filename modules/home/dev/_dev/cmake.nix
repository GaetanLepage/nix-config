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
    lsp.servers.cmake.enable = true;
    plugins.lsp-format.settings.cmake.exclude = [ "cmake" ];
  };
}

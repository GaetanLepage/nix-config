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
    plugins.lsp.servers.cmake = {
      enable = true;
      package =
        let
          formatConfigFile = pkgs.writers.writeJSON "cmake-format-config.json" {
            format.dangle_parens = true;
          };
        in
        pkgs.cmake-language-server.overrideAttrs (old: {
          postPatch =
            ''
              substituteInPlace cmake_language_server/server.py \
                --replace-fail \
                  '["cmake-format",' \
                  '["cmake-format", "--dangle-parens", "true",'
            ''
            # '["cmake-format", "--config-file", "${formatConfigFile}",'
            + (old.postPatch or "");

          disabledTests = [ "test_formatting" ] ++ (old.disabledTests or [ ]);
        });
    };
  };
}

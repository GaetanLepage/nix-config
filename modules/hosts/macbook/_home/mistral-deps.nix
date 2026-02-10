{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    stdenv.cc.cc
  ];

  home.sessionVariables = {
    LIBRARY_PATH = lib.makeLibraryPath (
      with pkgs;
      [
        # libc++
        stdenv.cc.cc
      ]
    );
  };
}

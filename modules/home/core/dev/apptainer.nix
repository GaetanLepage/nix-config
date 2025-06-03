{
  flake.modules.homeManager.core = {
    # inria
    programs.nixvim = {
      filetype.extension.def = "apptainer";

      # Use the bash parser for apptainer files
      plugins.treesitter.languageRegister.bash = [ "apptainer" ];
    };
  };
}

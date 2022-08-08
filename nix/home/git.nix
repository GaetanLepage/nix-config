{ config, ... }:

{
    programs.git = {
        enable = true;

        userEmail = "gaetan.lepage@inria.fr";
        userName = "Gaetan Lepage";

        extraConfig = {
            core.editor = "nvim";
            github.user = "GaetanLepage";
            mergetool.prompt = false;
            pull.rebase = false;
        };
    };
}

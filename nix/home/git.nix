{ config, ... }:

{
    programs = {
        git = {
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

        lazygit = {
            enable = true;
            settings.gui = {
                showFileTree = false;

                theme = {
                    activeBorderColor = [ "blue" "bold" ];
                    selectedLineBgColor = [ "white" ];
                };
            };
        };
    };

    home.shellAliases = {
        g   = "git";
        lg  = "lazygit";

        # add
        ga  = "git add";
        gaa = "git add *";

        # commit
        gc  = "git commit";
        gcm = "git commit -m";
        gca = "git commit -am";

        # pull/push
        gpl = "git pull";
        gps = "git push";

        gs  = "git status";
        gd  = "git diff";
        gch = "git checkout";
        gnb = "git checkout -b";
        gac = "git add . && git commit";
        grs = "git restore --staged .";
        gre = "git restore";
        gr  = "git remote";
        gcl = "git clone";
        gt  = "git ls-tree -r master --name-only";
        gb  = "git branch";
        gm  = "git merge";
        gf  = "git fetch";
    };
}

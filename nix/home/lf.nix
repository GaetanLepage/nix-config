{ ... }:

{
    programs.lf = {
        enable = true;

        commands = {
            # open = ''
            # '';

            # mkdir = "$printf 'Directory name: '; read answer; mkdir $answer";
        };

        # extraConfig = ''
        #     cmd mkdir $\{{
        #         printf "Directory Name: "
        #         read ans
        #         mkdir $ans
        #     }}
        # '';

        keybindings = {
            D = "delete";
            "<f-7>" = "mkdir";
        };

        cmdKeybindings = {
        };

        settings = {
            ignorecase = true;
        };
    };

    home.shellAliases.r = "lf";
}

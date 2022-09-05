{
    pkgs,
    ...
}:

{
    home = {

        packages = let
            remi = pkgs.python3.pkgs.buildPythonApplication rec {

                pname = "remi";
                version = "1.1.1";

                src = fetchGit {
                    url = "ssh://git@gitlab.inria.fr/remote-inria/remi.git";
                    rev = "672ff448422646c4f808662db2092d4b7d79d786";
                };

                propagatedBuildInputs = with pkgs.python3Packages; [
                    termcolor
                    click
                    pyyaml
                ];
            };

        in [ remi ];

        shellAliases = {
            rp      = "remi push";
            rpf     = "remi push -f";
            rbc     = "remi build-container";
            rbcf    = "remi build-container -f";
            rda     = "remi desktop attach-session";
            rd      = "remi desktop";
            rdc     = "remi desktop command";
            rdi     = "remi desktop interactive";
            rdeu    = "remi desktop -s exputils.sh";
            rc      = "remi cluster";
            rcc     = "remi cluster command";
            rci     = "remi cluster interactive";
            rck     = "remi cluster kill";
            rceu    = "remi cluster -s exputils.sh";
            rt      = "remi tensorboard";
            rst     = "remi ssh-tunnel";
        };
    };
}

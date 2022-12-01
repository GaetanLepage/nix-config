{ pkgs, config, ... }:

{
    home = {
        packages = with pkgs; [
            cargo
            rustc
            rustfmt
        ];

        sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";
    };
}

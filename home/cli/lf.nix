{ pkgs, config, ... }:

{
    programs = {
        lf = {
            enable = true;

            commands = {
                "yank-dirname"  = "$dirname     -- '$f' | head -c-1 | xclip -i -selection clipboard";
                "yank-path"     = "$printf '%s'   '$fx'             | xclip -i -selection clipboard";
                "yank-basename" = "$basename -a -- $fx  | head -c-1 | xclip -i -selection clipboard";
            };

            extraConfig =

                let
                    cleaner = pkgs.writeShellScript "pv.sh" ''
                        #!/bin/sh

                        kitty +icat --clear --silent --transfer-mode file
                    '';

                in ''
                    cmd open $ {{
                        case $f in
                            *.log|*.stdout|*.stderr)
                                less +G -- "$f" ;;
                            *)
                                case $(file --mime-type "$f" -bL) in
                                    text/*|application/json)
                                        $EDITOR "$f" ;;
                                    *)
                                        xdg-open "$f" ;;
                                esac
                                ;;
                        esac
                    }}

                    cmd mkdir $ {{
                        printf "Directory Name: "
                        read ans
                        mkdir $ans
                    }}

                    set cleaner ${cleaner}

                    # Enable mouse
                    set mouse true
                '';

            keybindings = {
                D       = "delete";
                "<f-7>" = "mkdir";
                gd      = "cd ${config.xdg.userDirs.download}";
                R       = "reload";

                "y"     = "";
                "yy"    = "copy";
                "yn"    = "yank-basename";
                "yp"    = "yank-path";
                "yd"    = "yank-dirname";
            };

            settings = {
                ignorecase  = true;
                drawbox     = true;
            };

            previewer.source = pkgs.writeShellScript "lf-previewer.sh" ''
                #!/bin/sh

                file=$1
                w=$2
                h=$3
                x=$4
                y=$5

                if [[ "$( file -Lb --mime-type "$file")" =~ ^image ]]; then
                    coordinates = $w"x"$h"x"$x"x"$y
                    kitty +icat --silent --transfer-mode file --place "$coordinates" "$file"
                    exit 1
                fi

                case "$1" in
                    *.tar*) tar tf "$file";;
                    *.zip) unzip -l "$file";;
                    *.rar) unrar l "$file";;
                    *.7z) 7z l "$file";;
                    *.pdf) pdftotext "$file" -;;
                    *) bat --color=always --plain "$file";;
                esac
            '';
        };

        # lfcd (cd to last visited directory)
        zsh.initExtra = ''
            lfcd () {
                tmp="$(mktemp)"
                lf -last-dir-path="$tmp" "$@"
                if [ -f "$tmp" ]; then
                    dir="$(cat "$tmp")"
                    rm -f "$tmp"
                    if [ -d "$dir" ]; then
                        if [ "$dir" != "$(pwd)" ]; then
                            cd "$dir"
                        fi
                    fi
                fi
            }
        '';
    };

    home.shellAliases.r = "lfcd";
}

{
  pkgs,
  config,
  ...
}: {
  programs = {
    lf = {
      enable = true;

      commands = {
        yank-dirname = "$dirname     -- '$f' | head -c-1 | xclip -i -selection clipboard";
        yank-path = "$printf '%s'   '$fx'             | xclip -i -selection clipboard";
        yank-basename = "$basename -a -- $fx  | head -c-1 | xclip -i -selection clipboard";
      };

      extraConfig = ''
        cmd open $ {{
            case $f in
                *.log|*.stdout|*.stderr)
                    less +G -- "$f" ;;
                *.wav)
                    paplay $f ;;
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
      '';

      keybindings = {
        # Misc.
        D = "delete";
        "<f-7>" = "mkdir";
        R = "reload";
        "<enter>" = "open";
        "." = "set hidden!";

        # Yank
        y = "";
        yy = "copy";
        yn = "yank-basename";
        yp = "yank-path";
        yd = "yank-dirname";

        # Common directories
        gd = "cd ${config.xdg.userDirs.download}";
        gr = "cd ${config.home.homeDirectory}/inria/code/rlan";
        ge = "cd ${config.home.homeDirectory}/inria/experiments/rlan/002_rlan_ssl";
      };

      settings = {
        ignorecase = true;
        drawbox = true;
      };

      previewer.source = pkgs.writeShellScript "lf-previewer.sh" ''
        file=$1
        case "$file" in
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
    fish.shellInit = ''
      function lfcd --wraps="lf" --description="lf - Terminal file manager (changing directory on exit)"
        # `command` is needed in case `lfcd` is aliased to `lf`.
        # Quotes will cause `cd` to not change directory if `lf` prints nothing to stdout due to an error.
        cd "$(command lf -print-last-dir $argv)"
      end
    '';
  };

  home.shellAliases.r = "lfcd";
}

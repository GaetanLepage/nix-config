#!/usr/bin/env bash
shopt -s extglob

pr_number=$1
arch=${2:-""}

current_dir=$(basename "$PWD")
if [ "$current_dir" != "nixpkgs" ]; then
    echo "Not in 'nixpkgs' directory. Aborting."
    exit 1
fi

if [ -z "$pr_number" ]; then
    echo "No PR given. Aborting"
    exit 1
fi

echo "Running nixpkgs-review for PR #$pr_number"

_mprocs="mprocs --server 127.0.0.1:4050"

session_name="review"
if ! tmux has-session -t "$session_name" &>/dev/null; then
    tmux new-session -d -s "$session_name"

    # start mprocs
    tmux send-keys -t "$session_name".0 "$_mprocs" C-m
fi

# Let the mprocs server enough time to start
sleep 1

function rev {
    echo ">>> $1"
    # command="nixpkgs-review pr --no-shell --post-result --system $1 $pr_number"
    command="echo $1 PR#$pr_number"
    name="$pr_number "
    case $1 in
    x86_64-linux)
        name+="linux_x86"
        ;;
    aarch64-linux)
        name+="linux_arm"
        ;;
    x86_64-darwin)
        name+="darwin_x86"
        ;;
    aarch64-darwin)
        name+="darwin_arm"
        ;;
    esac

    $_mprocs --ctl "{
        c: batch,
        cmds: [
            {c: add-proc, cmd: '$command'},
            {c: rename-proc, name: '$name'}
        ]
    }"
    sleep 1
}

case $arch in
all | "")
    rev x86_64-linux
    rev aarch64-linux
    rev x86_64-darwin
    rev aarch64-darwin
    ;;

+(i|a|d|m))

    case $arch in
    *i*)
        rev x86_64-linux
        ;;&
    *a*)
        rev aarch64-linux
        ;;&
    *d*)
        rev x86_64-darwin
        ;;&
    *m*)
        rev aarch64-darwin
        ;;
    esac
    ;;
esac

tmux attach-session -t "$session_name"

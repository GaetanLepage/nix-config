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

tmux new-session -d -s "$pr_number"

window_id=1

function rev {
	echo ">>> $1"
	tmux new-window -t "$pr_number":"$window_id"
	tmux rename-window -t "$pr_number":"$window_id" "$1"

	command="nixpkgs-review pr --no-shell --post-result --system $1 $pr_number"
	tmux send-keys -t "$pr_number":"$window_id" "$command" C-m

	((window_id++))
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

# Close window 0
tmux kill-window -t "$pr_number":0

tmux attach-session -t "$pr_number"

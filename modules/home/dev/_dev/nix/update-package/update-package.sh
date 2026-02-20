pname="$1"
branch_name="update/$pname"

set -eu

function log() {
    echo "-------------------------------------------------------"
    echo "=> $1"
    echo "-------------------------------------------------------"
}

log "Checking out master"
git switch master
git pull

log "Checking out new branch '$branch_name'"
git switch -c "$branch_name"

log "Updating '$pname'"
nix-update --commit "$@"

pr_template=$(cat .github/PULL_REQUEST_TEMPLATE.md)

commit_subject=$(git log -1 --pretty=%s)
commit_body=$(git log -1 --pretty=%b)

get_maintainers=$(
    cat <<-END
  with import ./. {};
  lib.pipe $pname.meta.maintainers [
    (builtins.catAttrs "github")
    (lib.filter (handle: handle != "GaetanLepage"))
    (map (handle: "@\${handle}"))
    (lib.concatStringsSep " ")
  ]
END
)

maintainers=$(nix-instantiate --eval -E "$get_maintainers" --raw)

commit_desc=$(echo "$commit_body" | sed '/^[[:space:]]*$/d')

pr_desc="$commit_desc"
if [ -n "$maintainers" ]; then
    pr_desc="$pr_desc

cc $maintainers"
fi

pr_body=$(awk -v replacement="$pr_desc" '
  BEGIN { found=0 }
  /^<!-- Please check what applies\./ {
    print replacement
    found=1
    next
  }
  { print }
' <<<"$pr_template")

log "Pushing changes to '$branch_name'"

git push -u origin "$branch_name"

log "Creating PR"

gh_pr_output=$(gh pr create --title "$commit_subject" --body "$pr_body")

echo "$gh_pr_output"

pr_number=$(echo "$gh_pr_output" | awk -F/ '/github.com.*\/pull\// {print $NF}')

read -r -p "Do you want to run nixpkgs-review? [Y/n] " response
response=${response,,} # to lowercase

if [[ "$response" =~ ^(yes|y|)$ ]]; then
    echo "Running nixpkgs-review..."
    nixpkgs-review pr --systems all "$pr_number"
fi

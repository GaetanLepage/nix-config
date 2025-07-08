pname="$1"
branch_name="update/$pname"

set -eu

function log() {
    echo "-------------------------------------------------------"
    echo "=> $1"
    echo "-------------------------------------------------------"
}

log "Checking out master"
git checkout master
git pull

log "Checking out new branch '$branch_name'"
git checkout -b "$branch_name"

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

change_desc="$commit_desc

cc $maintainers
"

pr_desc=$(awk -v replacement="$change_desc" '
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

gh_pr_output=$(gh pr create --title "$commit_subject" --body "$pr_desc")

echo "$gh_pr_output"

pr_number=$(echo "$gh_pr_output" | awk -F/ '/github.com.*\/pull\// {print $NF}')

read -r -p "Do you want to run nixpkgs-review-gha? [Y/n] " response
response=${response,,} # to lowercase

if [[ "$response" =~ ^(yes|y|)$ ]]; then
    echo "Running nixpkgs-review-gha..."
    gh workflow \
        run review.yml \
        --ref main \
        --repo GaetanLepage/nixpkgs-review-gha \
        --field pr="$pr_number"
fi

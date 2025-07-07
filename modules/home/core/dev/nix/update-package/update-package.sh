pname="$1"
branch_name="update/$pname"

set -eu

git checkout master
git pull
git checkout -b "$branch_name"

nix-update --commit "$pname"

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

git push -u origin "$branch_name"

gh pr create \
    --title "$commit_subject" \
    --body "$pr_desc"

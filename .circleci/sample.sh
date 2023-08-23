
# forceAll='false'
# baseRevision='module'
# modulesFiltered='./tmp/modules-filtered.txt'

# modules='apps/module-a
#           apps/module-b
#           apps/module-c apps/module-b'

modules=$(cat <<EOF
apps/module-a
apps/module-b
apps/module-c apps/module-b
EOF
)

echo "$modules"


# # Add each module to `modules-filtered` if 1) `force-all` is set to `true`, 2) there is a diff against `base-revision`, 3) there is no `HEAD~1` (i.e., this is the very first commit for the repo) OR 4) there is a diff against the previous commit
# cat \<< EOD | sed -e '/^$/d' | while read row; do module="$(echo "$row" | awk '{ print $1 }')"; if [ $forceAll == 'true' ] || [ $(git diff --name-only $baseRevision "$module" | wc -l) -gt 0 ] || (! git rev-parse --verify HEAD~1) || [ $(git diff --name-only HEAD~1 "$module" | wc -l) -gt 0 ]; then echo "$row" | sed -e 's/ /\n/g' >> $modulesFiltered; fi; done
# "$modules"
# EOD

####  cat << EOF" examples ####

# sql=$(cat <<EOF
# SELECT foo, bar FROM db
# WHERE foo='baz'
# EOF
# )
# sql2="SELECT foo, bar FROM db WHERE foo='baz'"
# echo "$sql"
# echo ""
# echo "$sql2"

# cat<<EOF > print.sh
# #!/bin/bash
# echo \$PWD
# echo $PWD
# EOF

# cat <<EOF | grep 'b' | tee b.txt
# foo
# bar
# baz
# EOF
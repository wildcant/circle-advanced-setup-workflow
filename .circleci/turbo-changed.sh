#!/bin/bash

DIR="$(cd "$(dirname "$1")" && pwd)"
PROJECT="admin"
TURBO_RUN_FILTER=...[HEAD^]

# Extract json from response of dry command.
json="$(echo `yarn build --filter=$TURBO_RUN_FILTER --dry-run=json` | grep -o '{.*}')"
echo $json
# Extract the packages that changed.
packages="$(echo "$json" | grep -o '"packages": \[[^]]*\]' | sed 's/"packages": \[\([^]]*\)\]/\1/' | tr -d '",[]')"
# packages=($(echo "$json" | grep -o '"packages": \[[^]]*\]' | sed 's/"packages": \[\([^]]*\)\]/\1/' | tr -d '",[]' | tr ' ' '\n'))
# packages=($packages_str)
# echo $packages

# echo "Packages that require deployment: (${packages[@]})"

# Check if the given packages is in the list of packages that changed.
# if [[ " ${packages[*]} " =~ " ${PROJECT} " ]]; then
#   packageChanged=true
# else
#   packageChanged=false
# fi
# echo "Project \"${PROJECT}\" requires deployment? ${packageChanged}"

echo "export FOO=$packages"


# temp=$FOO
# echo "${temp[@]}"
# temp2="sample"
# if [[ " ${temp[*]} " =~ " ${temp2} " ]]; then
#   echo yes
# else
#   echo no
# fi
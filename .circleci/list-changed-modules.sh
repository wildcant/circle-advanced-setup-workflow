#!/bin/bash


# modules=$(cat <<EOF
# apps/frontend-v1
# apps/frontend-v2
# apps/module-a
# apps/module-b
# apps/module-c
# apps/module-d
# EOF
# ) # << parameters.modules >>
# force_all='false' # << parameters.force-all >>
modules_filtered='output.txt' # << parameters.modules-filtered >>

echo 'generating diff with turbo'
input=$(npx turbo run build --filter='{./apps/*}...[HEAD^]' --dry-run=json | yq '.packages')
echo $input
echo ''

# Remove the square brackets and quotes from the input string
cleaned_input=$(echo "$input" | tr -d '[]"' | tr ',' '\n')
echo 'Cleared list of apps that changed' $cleaned_input
echo ''

# If app changed list is empty then exit.
if [ -z "$cleaned_input" ]
then
  echo 'No package changed, exiting.'
  circleci-agent step halt
  exit
fi

# Create the output file and write the filtered and cleaned input to it
echo "$cleaned_input" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | grep -v '//' | sed 's/^/apps\//' > "$modules_filtered"

echo 'Output has been written to' $modules_filtered  ' with the following content:'

cat $modules_filtered
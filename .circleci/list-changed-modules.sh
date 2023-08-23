#!/bin/bash

modules_filtered='output.txt' # << parameters.modules-filtered >>

echo 'generating diff with turbo'
input=$(npx turbo run build --filter='...^[HEAD^]' --dry-run=json | yq e '.packages' -)
echo $input
echo ''

# Remove the square brackets and quotes from the input string
echo 'Remove the square brackets and quotes from the input string'
cleaned_input=$(echo "$input" | tr -d '[]"' | tr ',' '\n')
echo $cleaned_input
echo ''

# Create the output file and write the filtered and cleaned input to it
echo "$cleaned_input" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | grep -v '//' | sed 's/^/apps\//' > "$modules_filtered"

echo 'Output has been written to' $modules_filtered  ' with the following content:'

cat $modules_filtered

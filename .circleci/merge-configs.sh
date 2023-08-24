#!/bin/bash

modules='output.txt' # << parameters.modules >>
shared_config='.circleci/config.yml' # << parameters.shared-config >>
continue_config='.circleci/continue-config.yml' # << parameters.continue-config >>

# If `modules` is unavailable, stop this job without continuation
if [ ! -f $modules ] || [ ! -s $modules ]
then
  echo 'Nothing to merge. Halting the job.'
  # circleci-agent step halt
  exit
fi

# Convert a list of dirs to a list of config.yml
sed -i -e 's/$/\/.circleci\/config.yml/g' "$modules"


# If `shared-config` exists, append it at the end of `modules`
if [ -f $shared_config ]
then
  echo 'appending shared config.'
  echo "$shared_config" >> "$modules"
fi

echo 'will merge the following config files:'
cat $modules
echo ''

# yq syntax changed after v4.18.
# yq v4.13.3 (current yq version at cimg/node:17.1.0) docs can be found at https://github.com/mikefarah/yq/tree/e052ff8025dae7fb040720e7901d40e8b7d5655f/pkg/yqlib/doc
# xargs api from macos is different from linux :/
xargs -a "$modules" yq eval-all '. as $item ireduce ({}; . * $item )' | tee "$continue_config"

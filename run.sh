#!/bin/bash

action=$1
arg1=$2
arg2=$2

execute() {
  substring="The requested URL returned error"
  sha=$(curl -sSL https://api.github.com/repos/WildePizza/ollama-kubernetes/commits?per_page=2 | jq -r '.[1].sha')
  url="https://raw.githubusercontent.com/WildePizza/ollama-kubernetes/HEAD/.commits/$sha/scripts/$action.sh"
  echo "Executing: $url"
  output=$(curl -fsSL $url 2>&1)
  if [[ $output =~ $substring ]]; then
    sleep 1
    execute
  else
    curl -fsSL $url | bash -s $sha $arg1 $arg2
  fi
}
execute

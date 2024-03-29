#!/usr/bin/env bash
__nsh__script=""
__nsh__interpreter=""
if [ $# -eq 1 ]; then
    __nsh__script=$1
    __nsh__interpreter=$SHELL
fi
if [ $# -eq 2 ]; then
    __nsh__script=$2
    __nsh__interpreter=$(which $1)
fi

__nsh__FULL_ENV_VARS=$(jq -n '$ENV')
__nsh__ALLOWED_ENV_VARS=$(nix eval --impure --json --expr "builtins.functionArgs (import $__nsh__script)")
__nsh__allowed_keys=$(jq 'keys' <<< "$__nsh__ALLOWED_ENV_VARS")
__nsh__filtered_env_vars=$(jq --argjson keys "$__nsh__allowed_keys" '. as $parent | with_entries(select(.key as $k | $keys | index($k)))' <<< "$(echo $__nsh__FULL_ENV_VARS)")
__nsh__env_vars=$(echo "$__nsh__filtered_env_vars" | jq -r 'to_entries|map("export \(.key)=\"\(.value|tostring)\"")|.[]')
exec env -i "$__nsh__interpreter" <(echo -e "$__nsh__env_vars" &&  nix eval --raw --impure --expr "import $__nsh__script ({} // builtins.fromJSON(''$__nsh__filtered_env_vars''))")
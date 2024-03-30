#/bin/bash

#nix eval --impure --expr  "builtins.functionArgs ((import ./nixshe.nix {}).getLaunchCommand)"

script_file=$(cat ./example.nix)
script_expr=$(sed -n '/^{[^}]*}/s/\({[^}]*}\).*/\1/p' ./example.nix)

#echo $script_expr
#
#echo "$script_expr: ''''"


val=$(nix-instantiate --eval \
--arg lib '(import <nixpkgs> {}).pkgs.lib' \
--argstr SHELL bash \
--arg SCRIPT_TO_EXECUTE "$script_expr: ''''" \
--arg ENV_VARS "builtins.fromJSON(''$(jq -n '$ENV')'')" \
./launch.nix )


echo -e "$val"
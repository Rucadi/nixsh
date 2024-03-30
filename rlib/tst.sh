#/bin/bash

#nix eval --impure --expr  "builtins.functionArgs ((import ./nixshe.nix {}).getLaunchCommand)"

getInputs() {
    script=$(cat $1)
    inst=$(nix-instantiate --parse -E "${script%%:*}:{}")
    inst=${inst%%:*}
    inst=${inst#*(}
    echo ${inst%%:*}
}

getLetExpr() {
    ./matching_let.awk "$1"
}

getInheritAttrSet()
{
    getInputs "$1" | sed -E 's/(\w+)/\1=\1;/g; s/;$/; /' | sed -E 's/,//g'
}


getParsedScript() {
    getInputs $1 | sed -e "s|{|{nixshe,|" 
    echo :
    getLetExpr $1
    getInheritAttrSet $1
}

getParsedScript ./example.nix
#getInputs ./example.nix
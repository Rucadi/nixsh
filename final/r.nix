#!/home/rucadi/nixsh/final/nixsh
{ nixsh,PATH ? "cata", DISPLAY ? "panadero", mandril ? "dafa", FOM}:
let
test = let test = "test"; in "a";
in
nixsh.wrapper {PATH=PATH; DISPLAY=DISPLAY; mandril=mandril; FOM=FOM;} ''/bin/bash''  
''
  echo "Hello, world!" | /bin/cowsay/${let a=1; in "test"}
  ../examples/parameter_passing/one.nixsh
''

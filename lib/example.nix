#!/home/rucadi/nixsh/nixshe
{TERM, PATH, DISPLAY}:
let
PATH = ${nixshe.pkgs.coreutils}/bin;
in 
''
  echo "Hello, world!" | ${nixshe.pkgs.cowsay}/bin/cowsay
  ../examples/parameter_passing/one.nixsh
''
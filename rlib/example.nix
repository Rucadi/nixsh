#!/home/rucadi/nixsh/nixshe
{TERM, PATH ? "cata", DISPLAY}:
let
PATH = "/bin";
test = let test = "test"; in "a";
in
''
  echo "Hello, world!" | /bin/cowsay/${let a=1; in "test"}
  ../examples/parameter_passing/one.nixsh
''


(
  { TERM, PATH ? "cata", DISPLAY }: 
  (let PATH = "/bin"; test = (let test = "test"; in "a"); in "echo \"Hello, world!\" | /bin/cowsay\n../examples/parameter_passing/one.nixsh\n")
  
)
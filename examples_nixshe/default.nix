#!/home/rucadi/nixsh/nixshe
{PATH,
TERM}:
''
  echo "Hello, world!" | ${pkgs.cowsay}/bin/cowsay
''
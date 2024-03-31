# NixSH: Enhance Your Scripting

NixSH aims to address common challenges encountered when using any SHELL-scripting language. It introduces two shell interpreters:

- `nixsh`
- `nixshl` (lite version)

`nixsh` is slightly slower as it builds a derivation and has access to the full nixpkgs. On the other hand, `nixshl` allows you to leverage the nix language capabilities to write bash scripts, including the built-in library and, if imported, nixpkgs. However, it does not build any derivation by itself. If you need to build derivations or access nixpkgs, you should use `nixsh`.

# Prerequisites
- Bash
- Nix (or nixstatic) with experimental commands
- jq

# Enhance Bash, Don't Replace It!

There's no need to replace your existing scripts to start benefiting from nixsh! You can start by incrementally replacing your bash scripts, and you'll see improvements even on the scripts that remain unchanged!

To start using NixSH, simply create a nix expression that returns the script. In the example below, the only environment variables inherited by the script will be PATH and TERM. It uses the "echo" command to print "Hello World". Note that you can likely copy and paste most bash scripts between the double quotes.

```bash
#!/usr/bin/env nixsh
{PATH, TERM}:
''
echo "Hello World"
''
```

Notice that other bash scripts or programs called from this script will have the env vars restricted to the ones this script has, which is good! Now you have control over your environment!

You can also use nix expressions to modify the ENV variables that the script will receive, and they will be applied when calling it!

```bash
#!/usr/bin/env nixsh
{PATH, TERM}:
let 
  TERM="unknown"
in
''
echo "${TERM}"
''
```

Or you can even set default values if a envar does not exists!
Did you know that you can also use nixpkgs directly?

```bash
#!/usr/bin/env nixsh
{PATH, TERM ? "unkown"}:
''
echo "${TERM}"
${nixsh.pkgs.cowsay}/bin/cowsay Mooooo
''
```


# Not-Only-Bash, Run any interpreter including python!

With NixSH, you can pass the interpreter in the shebang declaration, the resulting expression will be passed directly to the interpreter.
Notice that it shares the same ENV principle, only the ENV variables specified are being inherited.

```python
#!/usr/bin/env -S nixsh /usr/bin/python3
{}:
let 
  Hello = "Hello World!";
in
''
  import os
  print(os.environ)
  print("${Hello}")
''
```

# C++ (or any language) for scripting?!

Nix allows us to build derivations... 
so why not profit from the nix ecosystem?

We can build any code, in place, and use it directly un our script, and the best part?
Nix caches the derivation, so if there is no change in the input parameters, you will only pay the compile penalty once!

This also helps reducing the complexity of using a language written in any other language in your bash scripts, and NIX serves as a kind-of
preprocessor too! Truly amazing.


```c++
#!/usr/bin/env nixsh
{PATH, TERM}:
let 
  myCppScript =

    # This only pays the penalty the first time it is compiled. If nothing changes in the environment, the binary is cached.
    nixsh.cpp.compile ''
        #include <iostream>
        #include <string>
        #include <sstream>
        int main() {

          std::istringstream iss("${PATH}");
          std::string token;
          while (std::getline(iss, token, ':')) {
            std::cout<<token<<std::endl;
          }
          return 0;
        }'';
in
''
  ${myCppScript} | ${nixsh.pkgs.bat}/bin/bat
''
```


# Environment Variables Nightmare
In NixSH you specify exactly which environment variables need to be available when calling the script,
failing to provide the environment variables that NixSH needs results in a failure.

This failure will be detected beforehand for NixSH scripts that call other NixSH scripts, which makes it feel like a compi 

# Parameter Passing
In NixSH you use environment variables as the main parameter passing between NixSH files, no more $1 or $2, just use a name and it will make sure that it exists when calling the function!

# Cached binaries, compile time check!
While nixsh entrypoint is usually when you decide to call the script from the terminal, since it uses nix underneath, 
you get some benefits even before the first line of your script begin executing:

- Nix ensures that files referenced by nix exists.
- Nix will cache the derivations if the environment variables didn't change, this includes compilations or use of packages. 

# Full Power of Nix Language
Profit from the whole Nix Language power from your simple bashscripting! 
Create code generators, include files, pass parameters, everything is possible!

# Add file association to vscode:

Add this configuration to settings.json

```
"files.associations": {
  "*.nixsh": "nix"
}
```
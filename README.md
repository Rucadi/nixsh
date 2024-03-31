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


# Not-Only-Bash, Run any interpreter including python!
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


# Environment Variables Nightmare
In NixSH you specify exactly which environment variables need to be available when calling the script,
failing to provide the environment variables that NixSH needs results in a failure.

This failure will be detected beforehand for NixSH scripts that call other NixSH scripts, which makes it feel like a compi 

# Parameter Passing
In NixSH you use environment variables as the main parameter passing between NixSH files, no more $1 or $2, just use a name and it will make sure that it exists when calling the function!

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
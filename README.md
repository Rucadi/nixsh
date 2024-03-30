# NixSH, a simple but effective way to write bash scripts

NixSH tries to solve most of the common problems when using any SHELL-scripting language.

This project introduces *TWO* shell interpreters:

- nixsh
- nixshl (lite version)

While nixsh is a little bit slower, this one builds a derivation and has acces to the full nixpkgs.

nixshl let's you use the nix language capabilities in order to write bash scripts, including the builtin library and, if you import it, nixpkgs. 
But it'll not build any derivation by itself, in case you want to build derivations or access nixpkgs, probably you want to use nixsh.

# Requirements
- bash
- nix (or nixstatic) with experimental commands
- jq

# Do not replace bash, improve it!

You don't need to replace your scripts to begin getting the benefits of using nixsh! 
You can begin replacing your bash scripts incrementally, and get the benefits even on bash scripts that remain untouched!

To begin using NixSH, you only have to create a nix expression that returns the script!

In this case, the only envars inherited to the script will be PATH and TERM. And will use the "echo" command to print hello world.
Notice that you probably can copy-paste most bash scripts between the double quotes  :D

```
#!/usr/bin/env nixsh
{PATH, TERM}:
''
  echo "Hello World"
''
```

Notice that other bash scripts or programs called from this script will have the env vars restricted to the ones this script has, which is good! Now you have control over your environment!


# Environment Variables Nightmare
In NixSH you specify exactly which environment variables need to be available when calling the script,
failing to provide the environment variables that NixSH needs results in a failure (In static-NixSH mode at first-execution time, In dynamic-NixSH mode, at runtime)

When executing a script, only the environment variables specified as nix inputs will be available.

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
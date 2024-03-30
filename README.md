# NixSH, a simple but effective way to write bash scripts

NixSH tries to solve most of the common problems when using any SHELL-scripting language.

Problems that NixSH solves:

# Environment Handling
In NixSH you specify exactly which environment variables need to be available when calling the script,
failing to provide the environment variables that NixSH needs results in a failure (In static-NixSH mode at first-execution time, In dynamic-NixSH mode, at runtime)

When executing a script, only the environment variables specified as nix inputs will be available.

# Parameter Passing
In NixSH you use environment variables as the main parameter passing between NixSH files!

# Full Power of Nix Language
Profit from the whole Nix Language power from your simple bashscripting! 
Use derivation outptus, call code generators, even use nixpkgs!


# Add file association to vscode:

Add this configuration to settings.json

```
"files.associations": {
  "*.nixsh": "nix"
}
```
{
  description = "A basic devshell with nixsh";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {inherit system;};
        nixsh  = pkgs.callPackage ./package.nix {};
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [gawk jq gnused gnugrep coreutils nixsh];
        };

        defaultPackage = nixsh;
      }
    );
}
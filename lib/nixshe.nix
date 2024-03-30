
{
  nixpkgs ? import <nixpkgs> {},
  modules ? []
}:
let 
  modulesImports = lib.foldr (module: import module { inherit nixpkgs; }) {} modules;
  pkgs = nixpkgs.pkgs;
  lib = nixpkgs.lib;
in 
{
  inherit pkgs;
  inherit lib;

  getLaunchCommand = import ./launch.nix;

}  // modulesImports
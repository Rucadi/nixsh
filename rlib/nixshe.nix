{
  nixpkgs ? import <nixpkgs> {},
  modules ? []
}:
let 
  modulesImports = lib.foldr (module: import module { inherit nixpkgs; }) {} modules;
  pkgs = nixpkgs.pkgs;
  lib = nixpkgs.lib;

  wrapper = {pkgs, ENV, script, SHELL}:
            let
              lib=pkgs.lib;
            in
            pkgs.writeShellScript "nixshe-wrapper"
            ''
              unset $(env | ${pkgs.gawk}/bin/awk -F= '{print $1}')
              ${lib.concatStringsSep "\n" (lib.mapAttrsToList (key: value: "export ${key}=${value}") ENV)}
              export SHELL=${SHELL}
              exec ${SHELL} ${pkgs.writeShellScript "nixshe_script" script}
            '';
in 
{
  inherit pkgs;
  inherit lib;
  inherit wrapper;

}  // modulesImports
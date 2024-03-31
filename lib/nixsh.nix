{
  nixpkgs ? import <nixpkgs> {},
  modules ? []
}:
let 
  modulesImports = lib.foldr (module: import module { inherit nixpkgs; }) {} modules;
  pkgs = nixpkgs.pkgs;
  lib = nixpkgs.lib;

  wrapper = ENV: SHELL: script:
            let
              lib=pkgs.lib;
            in
            pkgs.writeShellScript "nixsh-wrapper"
            ''
              unset $(env | ${pkgs.gawk}/bin/awk -F= '{print $1}')
              ${lib.concatStringsSep "\n" (lib.mapAttrsToList (key: value: ''export ${key}='${value}' '') ENV)}
              export SHELL=${SHELL}
              exec ${SHELL} ${pkgs.writeShellScript "nixsh_script" script}
            '';

  cpp = rec {
    compileWithCmd = compile-command: source: pkgs.stdenv.mkDerivation rec {
      name = "nixsh-cpp-script";
      pname = "cpp-script";
      version = "0.1";
      dontUnpack = true;
      src = pkgs.writeText "main.cpp" source;
      buildPhase = ''
        ${compile-command} ${src} -o $out
      '';
    }; 
    compile = source: compileWithCmd "g++ -std=c++23 -O3" source; 

  };
in 
{
  inherit pkgs;
  inherit lib;
  inherit wrapper;
  inherit cpp;

}  // modulesImports
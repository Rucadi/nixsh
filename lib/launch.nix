{lib, ENV_VARS, SCRIPT_TO_EXECUTE, SHELL}:
let 
  script_vars = builtins.functionArgs(SCRIPT_TO_EXECUTE);
  allowed_environment_variables = lib.attrsets.filterAttrs (key: value: (builtins.hasAttr key script_vars ) ) ENV_VARS;
in
''
  ${lib.concatStringsSep "\n" (lib.mapAttrsToList (key: value: "export ${key}=${value}") allowed_environment_variables)}
''
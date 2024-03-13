{config, ...}: let
  inherit (config.nixvim) helpers;
in {
  lib.moovim = rec {
    mkLazyKey = {
      lhs,
      rhs,
      desc,
    }: ((helpers.listToUnkeyedAttrs [lhs rhs]) // {inherit desc;});

    mkLazyKeys = bindings: {
      __raw = helpers.toLuaObject (builtins.map mkLazyKey bindings);
    };
  };
}

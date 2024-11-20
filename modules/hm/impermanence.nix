{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.home.persistence = mkOption {
    description = "Additional persistence config for the given source path";
    default = { };
    type = types.attrsOf (
      types.submodule {
        options = {
          files = mkOption {
            description = "Additional files to persist via NixOS impermanence.";
            type = types.listOf (types.either types.attrs types.str);
            default = [ ];
          };

          directories = mkOption {
            description = "Additional directories to persist via NixOS impermanence.";
            type = types.listOf (types.either types.attrs types.str);
            default = [ ];
          };
        };
      }
    );
  };
}

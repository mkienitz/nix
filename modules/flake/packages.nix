{ inputs, ... }:
{
  # TODO (1) Maybe define an option like this here:
  # option.packages = [
  #   {
  #     name = "deploy";
  #     # Implicit:
  #     # path = inputs.packages + "/${name}"
  #     overrides = { };
  #   }
  # ];
  perSystem =
    {
      system,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: _prev: {
            deploy = final.callPackage (import (inputs.packages + "/deploy.nix")) { };
            cleanup = final.callPackage (import (inputs.packages + "/cleanup")) { };
            # TODO (2) And here a expression that maps config.packages...
          })
        ];
      };
    };
}

{ inputs, ... }:
{
  imports = [
    inputs.pre-commit-hooks.flakeModule
  ];

  perSystem = _: {
    pre-commit.settings.hooks = {
      deadnix.enable = true;
      statix.enable = true;
      treefmt.enable = true;
    };
  };
}

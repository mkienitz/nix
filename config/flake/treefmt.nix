{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = _: {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        beautysh.enable = true;
        deadnix.enable = true;
        nixfmt.enable = true;
        statix.enable = true;
      };
    };
  };
}

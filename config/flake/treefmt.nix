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
        nixfmt.enable = true;
      };
    };
  };
}

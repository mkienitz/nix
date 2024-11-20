{ inputs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    registry.p.flake = inputs.nixpkgs;
    registry.t.flake = inputs.nix-templates;
  };
}

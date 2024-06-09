{inputs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    registry.p.flake = inputs.nixpkgs;
  };
}

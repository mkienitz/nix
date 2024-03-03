{inputs, ...}: {
  imports = [
    inputs.home-manager.darwinModules.default
    ../../modules/darwin
    ../../users/max
    ../../users/max/graphical/homebrew.nix
  ];
  nix.settings.extra-sandbox-paths = ["/tmp/agenix-rekey"];
}

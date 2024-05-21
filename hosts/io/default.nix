{inputs, ...}: {
  imports = [
    inputs.home-manager.darwinModules.default
    ../../modules/darwin
    ../../modules/darwin/homebrew.nix
    ../../users/max
  ];
  nix.settings.extra-sandbox-paths = ["/tmp/agenix-rekey"];
}

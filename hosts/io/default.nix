{...}: {
  imports = [
    ../../modules/darwin
    ../../users/max
    ../../users/max/graphical/homebrew.nix
  ];
  nix.settings.extra-sandbox-paths = ["/tmp/agenix-rekey"];
}

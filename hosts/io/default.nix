{
  imports = [
    ../../modules/darwin
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/gui/stylix.nix
    ../../modules/darwin/hm.nix
  ];
  nix.settings.extra-sandbox-paths = ["/tmp/agenix-rekey"];
}

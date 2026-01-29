{
  inputs,
  ...
}:
{
  flake.darwinConfigurations = inputs.self.lib.mkDarwinHost "io" "aarch64-darwin";
}

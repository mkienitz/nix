{
  inputs,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixosHost "hygiea" "aarch64-linux";
}

{
  inputs,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixosHost "phoebe" "aarch64-linux";
}

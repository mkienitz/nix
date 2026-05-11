{
  inputs,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixosHost "phoebe" "x86_64-linux";
}

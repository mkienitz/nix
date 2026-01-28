{
  inputs,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixosHost "iapetus" "x86_64-linux";
}

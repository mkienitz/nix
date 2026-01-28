{
  inputs,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixosHost "gonggong" "aarch64-linux";
}

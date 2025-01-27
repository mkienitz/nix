{
  inputs,
  ...
}:
{
  imports = [ inputs.bipper.nixosModules.default ];

  services.bipper = {
    enable = true;
    address = "127.0.0.1";
    port = 3939;
    storageDuration = "1h";
  };
}

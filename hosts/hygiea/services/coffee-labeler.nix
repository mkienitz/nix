{inputs, ...}: {
  imports = [inputs.coffee-labeler.nixosModules.default];

  services.coffee-labeler = {
    enable = true;
    address = "127.0.0.1";
    port = 10000;
    printer-address = "192.168.178.39";
    printer-port = 9100;
  };
}

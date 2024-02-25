{inputs, ...}: {
  imports = [inputs.coffee-labeler.nixosModules.default];

  services.coffee-labeler-web = {
    enable = true;
    address = "127.0.0.1";
    port = 10000;
  };

  services.coffee-labeler-print = {
    enable = true;
    address = "127.0.0.1";
    port = 10001;
    printer-address = "192.168.178.36";
  };
}

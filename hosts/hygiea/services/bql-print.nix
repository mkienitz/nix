{ inputs, ... }:
let
  bqlPrintPort = 10001;
in
{
  imports = [ inputs.bql-print.nixosModules.default ];

  networking.firewall.allowedTCPPorts = [ bqlPrintPort ];

  services.bql-print = {
    enable = true;
    address = "0.0.0.0";
    port = bqlPrintPort;
    printer-address = "192.168.178.39";
    printer-port = 9100;
  };
}

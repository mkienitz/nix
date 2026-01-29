{ inputs, ... }:
{
  flake.modules.nixos.coffee-labeler =
    let
      coffee-labeler-domain = "label.maxkienitz.com";
    in
    { config, ... }:
    {
      imports = [
        inputs.coffee-labeler.nixosModules.default
        inputs.self.modules.nixos.acme-maxkienitz.com
      ];

      services.coffee-labeler = {
        enable = true;
        address = "127.0.0.1";
        port = 10000;
        printer-address = "192.168.178.39";
        printer-port = 9100;
      };

      security.acme.certs.${coffee-labeler-domain}.inheritDefaults = true;

      services.nginx = {
        upstreams = {
          coffee-labeler =
            let
              inherit (config.services.coffee-labeler) address port;
            in
            {
              servers."${address}:${toString port}" = { };
              extraConfig = ''
                zone coffee-labeler 64k;
                keepalive 5;
              '';
            };
        };
        virtualHosts.${coffee-labeler-domain} = {
          forceSSL = true;
          useACMEHost = coffee-labeler-domain;
          locations = {
            "/" = {
              proxyPass = "http://coffee-labeler";
              proxyWebsockets = true;
              extraConfig = ''
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Forwarded-Proto $scheme;
              '';
            };
          };
        };
      };
    };
}

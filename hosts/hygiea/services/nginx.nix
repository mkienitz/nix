{config, ...}: let
  coffee-labeler-domain = "label.maxkienitz.com";
in {
  imports = [../../../config/nixos/acme/maxkienitz.com];

  networking.firewall.allowedTCPPorts = [80 443];
  security.acme.certs.${coffee-labeler-domain}.inheritDefaults = true;

  services.nginx = {
    enable = true;
    upstreams = {
      coffee-labeler = let
        inherit (config.services.coffee-labeler) address port;
      in {
        servers."${address}:${toString port}" = {};
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
}

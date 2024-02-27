{config, ...}: let
  coffee-labeler-domain = "label.maxkienitz.com";
in {
  imports = [../../../modules/nixos/acme/maxkienitz.com];

  networking.firewall.allowedTCPPorts = [80 443];
  security.acme.certs.${coffee-labeler-domain}.inheritDefaults = true;

  services.nginx = {
    enable = true;
    virtualHosts.${coffee-labeler-domain} = {
      forceSSL = true;
      useACMEHost = coffee-labeler-domain;
      locations."/" = {
        proxyPass = let
          inherit (config.services.coffee-labeler-web) address port;
        in "http://${address}:${toString port}/";
        extraConfig = ''
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-Host $host;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };
}

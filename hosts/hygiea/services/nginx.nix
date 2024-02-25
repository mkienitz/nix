{config, ...}: {
  age.secrets.acme-cloudflare-zone-token.rekeyFile = ../secrets/acme-cloudflare-zone-token.age;
  age.secrets.acme-cloudflare-dns-token.rekeyFile = ../secrets/acme-cloudflare-dns-token.age;

  networking.firewall.allowedTCPPorts = [80 443];
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "contact@maxkienitz.com";
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      reloadServices = ["nginx"];
      credentialFiles = {
        CF_ZONE_API_TOKEN_FILE = config.age.secrets.acme-cloudflare-zone-token.path;
        CF_DNS_API_TOKEN_FILE = config.age.secrets.acme-cloudflare-dns-token.path;
      };
      group = "nginx";
    };
    certs = {
      "label.maxkienitz.com".inheritDefaults = true;
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts = let
      defaults = {
        forceSSL = true;
        useACMEHost = "label.maxkienitz.com";
      };
    in {
      "label.maxkienitz.com" =
        defaults
        // {
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
  };
}

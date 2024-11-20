{ config, ... }:
{
  age.secrets.acme-cloudflare-zone-token.rekeyFile = ./secrets/acme-cloudflare-zone-token.age;
  age.secrets.acme-cloudflare-dns-token.rekeyFile = ./secrets/acme-cloudflare-dns-token.age;
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "contact@maxkienitz.com";
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      reloadServices = [ "nginx" ];
      credentialFiles = {
        CF_ZONE_API_TOKEN_FILE = config.age.secrets.acme-cloudflare-zone-token.path;
        CF_DNS_API_TOKEN_FILE = config.age.secrets.acme-cloudflare-dns-token.path;
      };
      group = "nginx";
    };
  };
}

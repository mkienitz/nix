# TODO Maybe use DRY instead of INHERITANCE aspect
{ inputs, ... }:
{
  flake.modules.nixos.nginx-cloudflare =
    {
      pkgs,
      ...
    }:
    {
      imports = [ inputs.self.modules.nixos.nginx-base ];
      security.acme = {
        acceptTerms = true;
        defaults = {
          email = "contact@maxkienitz.com";
        };
      };
      services.nginx = {
        appendHttpConfig = ''
          ssl_client_certificate ${
            pkgs.fetchurl {
              url = "https://developers.cloudflare.com/ssl/static/authenticated_origin_pull_ca.pem";
              hash = "sha256-wU/tDOUhDbBxn+oR0fELM3UNwX1gmur0fHXp7/DXuEM=";
            }
          };
          ssl_verify_client on;
        '';
      };
    };
}

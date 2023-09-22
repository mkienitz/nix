{
  pkgs,
  config,
  ...
}: {
  networking.firewall.allowedTCPPorts = [80 443];
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "contact@kienitz.dev";
    };
  };
  services.nginx = {
    enable = true;
    virtualHosts = let
      defaults = {
        forceSSL = true;
        enableACME = true;
      };
    in {
      "kienitz.dev" =
        defaults
        // {
          locations."/".extraConfig = ''
            default_type text/html;
                 return 404 "<img src=\"https://http.cat/404.jpg\">";
          '';
        };
      "paypal.kienitz.dev" =
        defaults
        // {
          locations."/".extraConfig = ''
            return 302 https://www.paypal.com/paypalme/maximiliankienitz;
          '';
        };
      "bipper.kienitz.dev" =
        defaults
        // {
          locations."/api/".proxyPass = let
            bipper = config.services.bipper;
          in "http://${bipper.address}:${toString bipper.port}/";
        };
    };
    appendHttpConfig = ''
      ssl_client_certificate ${pkgs.fetchurl {
        url = "https://developers.cloudflare.com/ssl/static/authenticated_origin_pull_ca.pem";
        hash = "sha256-wU/tDOUhDbBxn+oR0fELM3UNwX1gmur0fHXp7/DXuEM=";
      }};
      ssl_verify_client on;
    '';
  };
}

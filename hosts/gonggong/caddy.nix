{pkgs, ...}: {
  services.caddy = {
    enable = true;
    globalConfig = ''
      auto_https off
      admin off
    '';
    extraConfig = ''
      (origin_pull) {
      	tls {
      		client_auth {
      			mode require_and_verify
      			trusted_ca_cert_file ${pkgs.fetchurl {
        url = "https://developers.cloudflare.com/ssl/static/authenticated_origin_pull_ca.pem";
        hash = "";
      }}
      		}
      	}
      }
    '';
    virtualHosts = {
      bipper = {
        hostName = "bipper.maxkienitz.com";
        extraConfig = ''
          import origin_pull
          handle /api/* {
          	reverse_proxy bipper:8000
          }
          root * /static/bipper-frontend
          file_server
        '';
      };
      default = {
        hostName = "maxkienitz.com";
        serverAliases = ["*.maxkienitz.com"];
        extraConfig = ''
          import origin_pull
          header {
          	Content-Type text/html
          }
          respond "<img src=\"https://http.cat/404.jpg\">" 404
        '';
      };
      paypal = {
        hostName = "paypal.maxkienitz.com";
        extraConfig = ''
          import origin_pull
          redir https://www.paypal.com/paypalme/maximiliankienitz
        '';
      };
      files = {
        hostName = "files.maxkienitz.com";
        extraConfig = ''
          import origin_pull
          root * /static/files
          file_server browse
        '';
      };
    };
  };
}

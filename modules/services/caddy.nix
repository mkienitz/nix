{...}: {
  networking.firewall.allowedTCPPorts = [80 443];
  services.caddy = {
    enable = true;
    virtualHosts = {
      default = {
        hostName = "kienitz.dev";
        extraConfig = ''
          header {
          	Content-Type text/html
          }
          respond "<img src=\"https://http.cat/404.jpg\">" 404
        '';
      };
      paypal = {
        hostName = "paypal.kienitz.dev";
        extraConfig = ''
          redir https://www.paypal.com/paypalme/maximiliankienitz
        '';
      };
    };
  };
}

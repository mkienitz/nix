{
  flake.modules.nixos.redirects = {
    services.nginx = {
      virtualHosts =
        let
          defaults = {
            forceSSL = true;
            enableACME = true;
          };
        in
        {
          "maxkienitz.com" = defaults // {
            locations."/".extraConfig = ''
              default_type text/html;
              return 404 "<img src=\"https://http.cat/404.jpg\">";
            '';
          };
          "paypal.maxkienitz.com" = defaults // {
            locations."/".extraConfig = ''
              return 302 https://www.paypal.com/paypalme/maximiliankienitz;
            '';
          };
        };
    };
  };
}

{
  config,
  inputs,
  ...
}:
let
  coffeeVaultDomain = "coffee.maxkienitz.com";
in
{
  # Setup ACME
  imports = [
    ../../../config/nixos/acme/maxkienitz.com
    inputs.coffee-vault.nixosModules.default
  ];
  security.acme.certs.${coffeeVaultDomain}.inheritDefaults = true;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  environment.persistence = {
    "/state".directories = [
      "/var/lib/acme/${coffeeVaultDomain}"
    ];
    "/persist".directories = [
      {
        directory = config.services.coffee-vault.workingDirectory;
        user = "coffee-vault";
        group = "coffee-vault";
        mode = "0750";
      }
    ];
  };

  services = {
    coffee-vault = {
      enable = true;
      port = 33333;
      domain = coffeeVaultDomain;
    };
    nginx = {
      enable = true;
      upstreams.coffee-vault =
        let
          inherit (config.services.coffee-vault) address port;
        in
        {
          servers."${address}:${builtins.toString port}" = { };
          extraConfig = ''
            zone coffee-vault 64k;
            keepalive 5;
          '';
        };
      virtualHosts.${coffeeVaultDomain} = {
        forceSSL = true;
        useACMEHost = coffeeVaultDomain;
        locations."/" = {
          proxyPass = "http://coffee-vault";
          proxyWebsockets = true;
        };
      };
    };
  };
}

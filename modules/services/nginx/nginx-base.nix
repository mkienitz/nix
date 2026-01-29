{
  flake.modules.nixos.nginx-base = {
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];

    services.nginx = {
      enable = true;
    };
  };
}

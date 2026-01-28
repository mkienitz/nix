_: {
  flake.modules.nixos.nginx = {
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];

    services.nginx = {
      enable = true;
    };
  };
}

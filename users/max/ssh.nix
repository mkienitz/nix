{
  # services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    matchBlocks = {
      vserver = {
        hostname = "45.157.178.176";
        user = "max";
        port = 22;
      };
      lxhalle = {
        hostname = "lxhalle.in.tum.de";
        user = "kienitz";
        port = 22;
      };

      gonggong = {
        hostname = "88.99.122.44";
        user = "max";
        port = 22;
      };

      hygiea = {
        hostname = "192.168.0.176";
        user = "max";
        port = 22;
      };
    };
    extraOptionOverrides = {
      AddKeysToAgent = "yes";
      IdentitiesOnly = "yes";
    };
  };
}

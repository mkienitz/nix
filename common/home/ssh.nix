{
  services.ssh-agent.enable = true;
  programs.ssh.matchBlocks = {
    vserver = {
      hostname = "45.157.178.176";
      user = "max";
      port = 22;
    };
  };
}

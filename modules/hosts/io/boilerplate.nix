{
  inputs,
  ...
}:
{
  flake.hosts.io = {
    class = "darwin";
    system = "aarch64-darwin";
    age = {
      rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILlq0WvbeFHTcNy7VNBU1es0gFtA757eCu7p12+6taSZ";
      identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  flake.darwinConfigurations = inputs.self.factory.host "io";
}

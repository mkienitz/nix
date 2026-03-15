{
  inputs,
  ...
}:
{
  flake.modules.darwin.io = {
    imports = with inputs.self.modules.darwin; [
      system-base
      secrets
      # user
      max
    ];

    age = {
      # TODO maybe pass to secret factory instead?
      rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILlq0WvbeFHTcNy7VNBU1es0gFtA757eCu7p12+6taSZ";
      identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };
}

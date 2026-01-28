{
  config,
  ...
}:
{
  flake.modules.nixos.hygiea = {
    imports = with config.flake.modules.nixos; [
      system-base
      secrets
      nginx
      bql-print
      coffee-labeler
    ];
    # TODO maybe pass to secret factory instead?
    age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBERuCQLB+iYaaZ7IIXkV1m014orlGAWF+NJqLkteTc9";
  };
}

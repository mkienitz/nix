{ config, ... }:
{
  age.secrets = {
    hetzner-sbox2-ssh-key.rekeyFile = ../secrets/hetzner-sbox2-ssh-key.age;
    backup-password.generator.script = "alnum";
  };
  services =
    let
      url = "u400140-sub1@${sboxHost}";
      sboxHost = "u400140.your-storagebox.de";
    in
    {
      restic.backups.persist = {
        paths = [ "/persist" ];
        repository = "sftp://${url}:23/";
        extraOptions = [
          "sftp.command='ssh -p23 ${url} -i ${config.age.secrets.hetzner-sbox2-ssh-key.path} -s sftp'"
        ];
        initialize = true;
        passwordFile = config.age.secrets.backup-password.path;
        timerConfig = {
          Persistent = true;
          OnCalendar = "02:00";
        };
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
          "--keep-yearly 75"
        ];
      };
      openssh.knownHosts.sbox2 = {
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIICf9svRenC/PLKIL9nk6K/pxQgoiFC41wTNvoIncOxs";
        hostNames = [ sboxHost ];
      };
    };
}

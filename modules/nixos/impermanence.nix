{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];
  environment.persistence = {
    "/state" = {
      hideMounts = true;
      directories = [
        "/var/lib/systemd"
        "/var/log"
        "/var/spool"
      ];
    };
    "/persist" = {
      hideMounts = true;
      files = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/machine-id"
      ];
    };
  };
  fileSystems."/state".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;
  boot.initrd.systemd = {
    enable = true;
    services.impermanence-root = {
      wantedBy = ["initrd.target"];
      after = ["zfs-import-rpool.service"];
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.zfs}/bin/zfs rollback -r rpool/local/root@blank";
      };
    };
  };
}

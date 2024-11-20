{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];
  config = lib.mkMerge [
    {
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
          directories = [
            "/var/lib/nixos"
          ];
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
          wantedBy = [ "initrd.target" ];
          after = [ "zfs-import-rpool.service" ];
          before = [ "sysroot.mount" ];
          unitConfig.DefaultDependencies = "no";
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.zfs}/bin/zfs rollback -r rpool/local/root@blank";
          };
        };
      };
    }
    # If home-manager is used, consume home.persistence options
    (lib.mkIf (config ? home-manager) (
      let
        inherit (lib)
          isAttrs
          mkMerge
          attrNames
          mapAttrs
          ;
        mkUserFiles = map (
          x: { parentDirectory.mode = "700"; } // (if isAttrs x then x else { file = x; })
        );
        mkUserDirs = map (x: { mode = "700"; } // (if isAttrs x then x else { directory = x; }));
      in
      {
        environment.persistence = mkMerge (
          map (
            user:
            let
              hmUserCfg = config.home-manager.users.${user};
            in
            mapAttrs (_: sourceCfg: {
              users.${user} = {
                files = mkUserFiles sourceCfg.files;
                directories = mkUserDirs sourceCfg.directories;
              };
            }) hmUserCfg.home.persistence
          ) (attrNames config.home-manager.users)
        );
      }
    ))
  ];
}

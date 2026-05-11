{ inputs, ... }:
{
  flake.modules.nixos.impermanence =
    {
      pkgs,
      lib,
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
      ];
    };

  flake.modules.homeManager.impermanence-glue =
    { lib, ... }:
    let
      inherit (lib) mkOption types;
    in
    {
      options.home.persistence = mkOption {
        description = "Additional persistence config for the given source path";
        default = { };
        type = types.attrsOf (
          types.submodule {
            options = {
              files = mkOption {
                description = "Additional files to persist via NixOS impermanence.";
                type = types.listOf (types.either types.attrs types.str);
                default = [ ];
              };

              directories = mkOption {
                description = "Additional directories to persist via NixOS impermanence.";
                type = types.listOf (types.either types.attrs types.str);
                default = [ ];
              };
            };
          }
        );
      };
    };
}

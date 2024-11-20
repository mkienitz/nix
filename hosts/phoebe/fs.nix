{ inputs, ... }:
{
  imports = [ inputs.disko.nixosModules.default ];
  boot.initrd.systemd.services."zfs-import-rpool".after = [ "cryptsetup.target" ];
  disko.devices = {
    disk = {
      nixnvme = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_1TB_S5GXNF0W173122H";
        content = {
          type = "gpt";
          partitions = {
            efi = {
              size = "1G";
              type = "ef00";
              priority = 1000;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            rpool = {
              size = "100%";
              content = {
                type = "luks";
                name = "luks";
                settings.allowDiscards = true;
                content = {
                  type = "zfs";
                  pool = "rpool";
                };
              };
            };
          };
        };
      };
    };
    zpool = {
      rpool = {
        type = "zpool";
        rootFsOptions = {
          compression = "zstd";
          acltype = "posix";
          atime = "off";
          xattr = "sa";
          dnodesize = "auto";
          mountpoint = "none";
          canmount = "off";
          devices = "off";
        };
        options.ashift = "12";

        datasets =
          let
            mkDataset = mountpoint: {
              type = "zfs_fs";
              options = {
                canmount = "noauto";
                inherit mountpoint;
              };
              inherit mountpoint;
            };
            mkUnmountable = {
              type = "zfs_fs";
            };
          in
          {
            "local" = mkUnmountable;
            "local/root" = mkDataset "/" // {
              postCreateHook = "zfs snapshot rpool/local/root@blank";
            };
            "local/nix" = mkDataset "/nix";
            "local/state" = mkDataset "/state";
            "safe" = mkUnmountable;
            "safe/persist" = mkDataset "/persist";
          };
      };
    };
  };
}

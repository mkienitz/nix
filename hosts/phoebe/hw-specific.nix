{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];
  boot = {
    initrd = {
      availableKernelModules = ["sdhci_pci" "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "r8169"];
      systemd = {
        enable = true;
        users.root.shell = "${pkgs.bashInteractive}/bin/bash";
        storePaths = ["${pkgs.bashInteractive}/bin/bash"];
        network = {
          enable = true;
          networks."10-eno1" = {
            matchConfig.Name = "eno1";
            DHCP = "yes";
          };
        };
      };
    };
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    loader.efi.canTouchEfiVariables = true;
  };

  # Lanzaboote
  boot.loader.systemd-boot.enable = false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  environment.persistence."/state".directories = ["/etc/secureboot"];

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  networking = {
    hostId = "de3825e6";
    hostName = config.node.hostname;
    useDHCP = true;
  };
}

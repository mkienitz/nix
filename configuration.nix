{
  config,
  pkgs,
  nixpkgs,
  home-manager,
  lib,
  ...
}: {
  imports = [home-manager.nixosModules.default];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };
  };

  networking = {
    hostName = "hygiea";
  };

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    registry.p.flake = nixpkgs;
  };

  environment.systemPackages = with pkgs; [vim];

  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
  };

  security.sudo = {
    execWheelOnly = false;
    wheelNeedsPassword = false;
  };

  users = {
    mutableUsers = false;
    users.max = {
      shell = pkgs.zsh;
      isNormalUser = true;
      hashedPassword = "$y$j9T$VCnJOOcqEduAbjfUu3lg.1$c6nV8lybLzpG1MMFicsvuL/AwUUni.4Zd9aCIbyJsMB";
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVcPOZFxCD1qSqCVXp5XYQ+yqJxI5kJ6PapuSOmnAIU MBP"];
    };
    users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVcPOZFxCD1qSqCVXp5XYQ+yqJxI5kJ6PapuSOmnAIU MBP"];
  };

  home-manager.users.max = {
    imports = [./home.nix];
    home.username = config.users.users.max.name;
  };

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.11";
}

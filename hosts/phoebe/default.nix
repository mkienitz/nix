{inputs, ...}: {
  imports = [
    # Machine
    ./fs.nix
    ./hw-specific.nix
    # NixOS
    ../../modules/nixos
    ../../modules/nixos/secrets
    ../../modules/nixos/impermanence.nix
    ../../modules/nixos/initrd-ssh.nix
    ../../modules/nixos/yubikey.nix
    ../../modules/nixos/wayland.nix
    # HM Nixos
    inputs.home-manager.nixosModules.default
    ../../users/max
    ../../users/max/nixos.nix
  ];
  # Home-Manager
  home-manager.users.max.imports = [
    ../../modules/hm/gui/hyprland.nix
  ];

  # programs.seahorse.enable = true;
  # services.gnome.gnome-keyring.enable = true;

  age.identityPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBivT5T9lDMrIL+hhRNEPr03lsBsgBV5jsELi61FGcIo";
}

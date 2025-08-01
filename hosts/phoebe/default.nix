{
  imports = [
    # Machine & HW
    ./hw-specific.nix
    ../../config/nixos/hw/lanzaboote.nix
    ../../config/nixos/hw/nvidia.nix
    ../../config/nixos/hw/pipewire.nix
    # NixOS
    ../../config/nixos
    ../../config/nixos/secrets
    ../../config/nixos/impermanence.nix
    ../../config/nixos/yubikey.nix
    ../../config/nixos/network.nix
    # GUI
    ../../config/nixos/gui/hyprland.nix
    # HM Nixos
    ../../config/nixos/hm.nix
  ];

  # Home-Manager
  home-manager.users.max.imports = [
    ../../config/hm/gui
    ../../config/hm/gui/programs
    ../../config/hm/gui/hyprland.nix
    ../../config/hm/gui/stylix.nix
  ];

  age.identityPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBivT5T9lDMrIL+hhRNEPr03lsBsgBV5jsELi61FGcIo";
}

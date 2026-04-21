{
  imports = [
    # Machine & HW
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

}

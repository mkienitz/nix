{pkgs, ...}: {
  services.nix-daemon.enable = true;
  services.nix-daemon.package = pkgs.nixFlakes;

  programs.zsh.enable = true;
}

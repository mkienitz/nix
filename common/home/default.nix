{pkgs, ...}: {
  imports = [./shell.nix ./git.nix ./ssh.nix];

  home.stateVersion = "23.11";
  home.packages = with pkgs; [file exa fd ripgrep];
}

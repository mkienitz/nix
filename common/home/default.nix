{pkgs, ...}: {
  imports = [./shell.nix ./git.nix];

  home.stateVersion = "23.11";
  home.packages = with pkgs; [file exa fd alejandra ripgrep deadnix];

  services.ssh-agent.enable = true;
}

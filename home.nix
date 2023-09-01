{
  config,
  pkgs,
  ...
}: {
  imports = [./shell.nix ./git.nix];

  home.stateVersion = "23.11";
  home.packages = with pkgs; [file exa fd alejandra ripgrep];

  services.ssh-agent.enable = true;
}

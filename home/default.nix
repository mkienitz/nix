{pkgs, ...}: {
  home-manager.users.max = {
    imports = [./shell.nix ./git.nix ./ssh.nix];
    home.username = "max";
    home.stateVersion = "23.11";
    home.packages = with pkgs; [file exa fd ripgrep];
  };
}

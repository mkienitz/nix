extra-imports: {pkgs, ...}: {
  home-manager.users.max = {
    imports = [./shell.nix ./git.nix ./ssh.nix] ++ extra-imports;
    home.username = "max";
    home.stateVersion = "23.11";
  };
}

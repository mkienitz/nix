extra-imports: {pkgs, ...}: {
  home-manager.users.max = {
    imports = [(import ./shell.nix pkgs) ./git.nix ./ssh.nix] ++ extra-imports;
    home.username = "max";
    home.stateVersion = "23.11";
  };
}

{pkgs, ...}: {
  home-manager.users.max = {
    imports = [
      ./shell
      ./git.nix
      ./ssh.nix
    ];
    home.username = "max";
    home.stateVersion = "23.11";
  };
}

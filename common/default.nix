{
  config,
  pkgs,
  nixpkgs,
  home-manager,
  ...
}: {
  imports = [home-manager.nixosModules.default];

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    registry.p.flake = nixpkgs;
  };

  environment.systemPackages = with pkgs; [vim];

  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
  };

  security.sudo = {
    execWheelOnly = false;
    wheelNeedsPassword = false;
  };

  time.timeZone = "Europe/Berlin";

  users = {
    mutableUsers = false;
    users.max = {
      shell = pkgs.zsh;
      isNormalUser = true;
      hashedPassword = "$y$j9T$VCnJOOcqEduAbjfUu3lg.1$c6nV8lybLzpG1MMFicsvuL/AwUUni.4Zd9aCIbyJsMB";
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVcPOZFxCD1qSqCVXp5XYQ+yqJxI5kJ6PapuSOmnAIU MBP"];
    };
    users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVcPOZFxCD1qSqCVXp5XYQ+yqJxI5kJ6PapuSOmnAIU MBP"];
  };

  home-manager.users.max = {
    imports = [./home];
    home.username = config.users.users.max.name;
  };

  system.stateVersion = "23.11";
}

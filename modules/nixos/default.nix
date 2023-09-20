{
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

  users = let
    authorizedKeys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKbdbkaOUCITGKH/XfDVg00dPE+iRHPFhNIUZ/SK+rbmAAAAC3NzaDpHZW5lcmFs Yubikey_5C_NFC_General"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVcPOZFxCD1qSqCVXp5XYQ+yqJxI5kJ6PapuSOmnAIU max@MBP"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIWPlordUa2k1CrHiFeROhIwv055d3ntijlu61s/cAuH root@MBP"
    ];
  in {
    mutableUsers = false;
    users.max = {
      shell = pkgs.zsh;
      isNormalUser = true;
      hashedPassword = "$y$j9T$VCnJOOcqEduAbjfUu3lg.1$c6nV8lybLzpG1MMFicsvuL/AwUUni.4Zd9aCIbyJsMB";
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = authorizedKeys;
    };
    users.root.openssh.authorizedKeys.keys = authorizedKeys;
  };

  system.stateVersion = "23.11";
}

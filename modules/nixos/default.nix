{
  pkgs,
  inputs,
  ...
}: {
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    registry.p.flake = inputs.nixpkgs;
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

  security.sudo.enable = false;
  time.timeZone = "Europe/Berlin";

  # To future potential docker user: WARY
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
  };

  users = let
    authorizedKeys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKbdbkaOUCITGKH/XfDVg00dPE+iRHPFhNIUZ/SK+rbmAAAAC3NzaDpHZW5lcmFs Yubikey_5C_NFC_General"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVcPOZFxCD1qSqCVXp5XYQ+yqJxI5kJ6PapuSOmnAIU max@MBP"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIWPlordUa2k1CrHiFeROhIwv055d3ntijlu61s/cAuH root@MBP"
    ];
  in {
    mutableUsers = false;
    users.root = {
      shell = pkgs.zsh;
      hashedPassword = "$y$j9T$VCnJOOcqEduAbjfUu3lg.1$c6nV8lybLzpG1MMFicsvuL/AwUUni.4Zd9aCIbyJsMB";
      openssh.authorizedKeys.keys = authorizedKeys;
    };
  };

  system.stateVersion = "23.11";
}

{pkgs, ...}: {
  imports = [
    ../common
  ];

  environment.systemPackages = with pkgs; [vim nvd];

  programs.git = {
    enable = true;
    config = {
      safe.directory = "*";
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  security.sudo.enable = false;
  time.timeZone = "Europe/Berlin";

  networking = {
    # To future potential docker user: WARY
    nftables.enable = true;
    firewall.enable = true;
  };

  users = {
    mutableUsers = false;
    users.root = {
      shell = pkgs.zsh;
      hashedPassword = "$y$j9T$kkv/hMvXX8zbPnlYpboNC.$/5RpeHyIbZGjKlbl1NFz9Iah01v.95xLLgGpOITX12B";
      openssh.authorizedKeys.keys = [
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKbdbkaOUCITGKH/XfDVg00dPE+iRHPFhNIUZ/SK+rbmAAAAC3NzaDpHZW5lcmFs Yubikey_5C_NFC_General"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVcPOZFxCD1qSqCVXp5XYQ+yqJxI5kJ6PapuSOmnAIU max@MBP"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIWPlordUa2k1CrHiFeROhIwv055d3ntijlu61s/cAuH root@MBP"
      ];
    };
  };

  system.stateVersion = "23.11";
}

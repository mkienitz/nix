{
  pkgs,
  lib,
  ...
}: {
  # Setup agent depending on arch
  launchd.agents.ssh-agent = lib.mkIf (pkgs.stdenv.isDarwin) {
    enable = true;
    config = {
      KeepAlive = true;
      RunAtLoad = true;
      ProgramArguments = [
        (toString (pkgs.writeShellScript "setup-ssh-agent-sock" ''
          ${pkgs.coreutils}/bin/rm -f "/tmp/ssh-agent.sock"
          ${pkgs.openssh}/bin/ssh-agent -D -a "/tmp/ssh-agent.sock"
        ''))
      ];
      StandardErrorPath = "/tmp/ssh-agent.err";
      StandardOutPath = "/tmp/ssh-agent.out";
      EnvironmentVariables = {
        SSH_ASKPASS = toString ./askpass.sh;
        DISPLAY = ":0";
      };
    };
  };
  services.ssh-agent.enable = !pkgs.stdenv.isDarwin;

  # General settings
  programs.ssh = {
    enable = true;
    matchBlocks = {
      lxhalle = {
        hostname = "lxhalle.in.tum.de";
        user = "kienitz";
        port = 22;
      };

      gonggong = {
        hostname = "88.99.122.44";
        user = "root";
        port = 22;
      };

      hygiea = {
        hostname = "192.168.178.32";
        user = "root";
        port = 22;
      };

      iapetus = {
        hostname = "192.168.178.37";
        user = "root";
        port = 22;
      };

      sbox = {
        hostname = "u368782.your-storagebox.de";
        user = "u368782";
        port = 23;
      };

      "bitbucket.ase.in.tum.de" = {
        hostname = "bitbucket.ase.in.tum.de";
        user = "git";
        port = 7999;
        identityFile = "~/.ssh/tum_ed25519";
      };
    };
    extraOptionOverrides = {
      AddKeysToAgent = "yes";
      IdentitiesOnly = "yes";
    };
  };
}

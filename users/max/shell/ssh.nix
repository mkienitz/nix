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
      EnvironmentVariables = let
        askpass =
          pkgs.writeShellScriptBin "askpass"
          (lib.readFile ./askpass.sh);
      in {
        SSH_ASKPASS = "${askpass}/bin/askpass";
        DISPLAY = ":0";
      };
    };
  };
  services.ssh-agent.enable = !pkgs.stdenv.isDarwin;

  # General settings
  programs.ssh = {
    enable = true;
    matchBlocks = {
      vserver = {
        hostname = "45.157.178.176";
        user = "max";
        port = 22;
      };
      lxhalle = {
        hostname = "lxhalle.in.tum.de";
        user = "kienitz";
        port = 22;
      };

      gonggong = {
        hostname = "88.99.122.44";
        user = "max";
        port = 22;
      };

      hygiea = {
        hostname = "192.168.0.176";
        user = "max";
        port = 22;
      };
    };
    extraOptionOverrides = {
      AddKeysToAgent = "yes";
      IdentitiesOnly = "yes";
    };
  };
}

{
  pkgs,
  lib,
  ...
}:
lib.mkMerge [
  {
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
      extraConfig = ''
        IdentityFile ~/.ssh/id_ed25519_sk2
      '';
      matchBlocks = rec {
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
        phoebe = {
          hostname = "192.168.178.29";
          user = "root";
          port = 22;
        };
        sbox1 = {
          hostname = "u368782.your-storagebox.de";
          user = "u368782";
          port = 23;
        };
        sbox1-synology = sbox1 // {
          user = "${sbox1.user}-sub1";
        };
        sbox2 = {
          hostname = "u400140.your-storagebox.de";
          user = "u400140";
          port = 23;
        };
        sbox2-iapetus = sbox2 // {
          user = "${sbox2.user}-sub1";
        };
        "artemis.tum.de" = {
          hostname = "artemis.tum.de";
          user = "git";
          port = 7921;
          identityFile = "~/.ssh/tum_ed25519";
        };
      };
    };
  }
  (lib.mkIf pkgs.stdenv.isLinux
    # (let
    #   askpass = lib.getExe (pkgs.writeShellApplication {
    #     name = "askpass";
    #     runtimeInputs = [pkgs.coreutils pkgs.gnugrep];
    #     text = ''
    #       TTY=$(tty)
    #       echo -e "[$(date)]\n\tARGS: $*\n\tSERVICE: ''${BURK:-no}\n\tTTY: $TTY" >> /tmp/askpassdebug.log
    #       if [[ "$1" == "Confirm user presence"* ]]
    #       then
    #           echo
    #       else
    #           PROMPT="SETDESC $1\nGETPIN"
    #         	PIN=$(echo -e "$PROMPT" | ${lib.getExe pkgs.pinentry-qt} | grep "^D" | tr -d '\n')
    #           echo "''${PIN:2}"
    #       fi
    #     '';
    #   });
    # in
    {
      home.persistence = {
        "/state".files = [
          "/.ssh/id_ed25519_sk"
          "/.ssh/id_ed25519_sk.pub"
          "/.ssh/id_ed25519_sk2"
          "/.ssh/id_ed25519_sk2.pub"
          "/.ssh/known_hosts"
        ];
        "/persist".directories = [
          "/Git"
          "/Downloads"
        ];
      };
      # services.ssh-agent.enable = true;
      # services.gnome-keyring.enable = true;
      # home.sessionVariables.SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      # systemd.user.services.gnome-keyring.Service.Environment = "SSH_ASKPASS=${pkgs.gnome.seahorse}/libexec/seahorse/ssh-askpass";
      # home.sessionVariables = {
      #   SSH_ASKPASS = askpass;
      #   SSH_ASKPASS_REQUIRE = "force";
      # };
      # systemd.user.services.ssh-agent.Service = {
      #   ExecStart = lib.mkForce "${pkgs.openssh}/bin/ssh-agent -d -a %t/ssh-agent";
      #   Environment = "SSH_ASKPASS=${askpass} DISPLAY=:0 BURK=yes";
      # };
    }
  )
  (lib.mkIf pkgs.stdenv.isDarwin {
    launchd.agents.ssh-agent = {
      enable = true;
      config = {
        KeepAlive = true;
        RunAtLoad = true;
        ProgramArguments = [
          (toString (
            pkgs.writeShellScript "setup-ssh-agent-sock" ''
              ${pkgs.coreutils}/bin/rm -f "/tmp/ssh-agent.sock"
              ${pkgs.openssh}/bin/ssh-agent -D -a "/tmp/ssh-agent.sock"
            ''
          ))
        ];
        StandardErrorPath = "/tmp/ssh-agent.err";
        StandardOutPath = "/tmp/ssh-agent.out";
        EnvironmentVariables = {
          BURK = "yes";
          SSH_ASKPASS = toString ./askpass.sh;
          SSH_ASKPASS_REQUIRE = "force"; # alternatively DISPLAY = ":0";
        };
      };
    };

    home.sessionVariables = {
      SSH_ASKPASS = toString ./askpass.sh;
      SSH_ASKPASS_REQUIRE = "force";
      SSH_AUTH_SOCK = "/tmp/ssh-agent.sock";
    };
  })
]

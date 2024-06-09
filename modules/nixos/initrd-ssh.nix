{
  config,
  pkgs,
  ...
}: {
  boot = {
    initrd = {
      systemd = {
        enable = true;
        users.root.shell = "${pkgs.bashInteractive}/bin/bash";
        storePaths = ["${pkgs.bashInteractive}/bin/bash"];
        network = {
          enable = true;
          # TODO extract option
          networks."10-eno1" = {
            matchConfig.Name = "eno1";
            DHCP = "yes";
          };
        };
      };
      network = {
        enable = true;
        ssh = {
          enable = true;
          port = 4;
          hostKeys = [config.age.secrets.initrd-host-ssh-key.path];
        };
      };
    };
  };
  age.secrets.initrd-host-ssh-key.generator.script = "ssh-ed25519";
  system.activationScripts = {
    # Make sure that there is always a valid initrd hostkey available that can be installed into
    # the initrd. When bootstrapping a system (or re-installing), agenix cannot succeed in decrypting
    # whatever is given, since the correct hostkey doesn't even exist yet. We still require
    # a valid hostkey to be available so that the initrd can be generated successfully.
    # The correct initrd host-key will be installed with the next update after the host is booted
    # for the first time, and the secrets were rekeyed for the the new host identity.
    agenixEnsureInitrdHostkey = {
      text = ''
        [[ -e ${config.age.secrets.initrd-host-ssh-key.path} ]] \
          || ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -N "" -f ${config.age.secrets.initrd-host-ssh-key.path}
      '';
      deps = ["agenixInstall" "users"];
    };
    agenixChown.deps = ["agenixEnsureInitrdHostkey"];
  };
}

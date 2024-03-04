{
  config,
  lib,
  ...
}: let
  paperlessDomain = "paperless.maxkienitz.com";
  paperlessConsumePath = "/paperless/consume";
  ftps_psv_min_port = 56260;
  ftps_psv_max_port = ftps_psv_min_port;
in {
  # Setup ACME
  imports = [../../../modules/nixos/acme/maxkienitz.com];
  security.acme.certs.${paperlessDomain}.inheritDefaults = true;

  age.secrets = {
    # vsftpd requires the .db suffix for the user database
    vsftpd-user-db = {
      rekeyFile = ../secrets/vsftpd-user-db.age;
      name = "vsftpUserDB.db";
    };
    paperless-ngx-password = {
      rekeyFile = ../secrets/paperless-ngx-password.age;
      group = "paperless";
      mode = "440";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [21 80 443];
    # Open port range for FTPS passive mode
    allowedTCPPortRanges = [
      {
        from = ftps_psv_min_port;
        to = ftps_psv_max_port;
      }
    ];
  };

  systemd = {
    # Create folder for scanner and share it with the paperless group
    tmpfiles.rules = [
      "d ${paperlessConsumePath} 2770 vsftpd paperless - -"
    ];
    # paperless-web service doesn't setup its own SCRATCH_DIR for whatever reason
    services.paperless-web.script = lib.mkBefore "mkdir -p /tmp/paperless";
  };

  services = {
    nginx = {
      upstreams.paperless = let
        inherit (config.services.paperless) address port;
      in {
        servers."${address}:${builtins.toString port}" = {};
        extraConfig = ''
          zone paperless 64k;
          keepalive 5;
        '';
      };
      enable = true;
      virtualHosts.${paperlessDomain} = {
        forceSSL = true;
        useACMEHost = paperlessDomain;
        extraConfig = ''
          client_max_body_size 512M;
        '';
        locations."/" = {
          proxyPass = "http://paperless";
          proxyWebsockets = true;
        };
      };
    };

    vsftpd = {
      enable = true;
      # Virtual users
      enableVirtualUsers = true;
      localUsers = true;
      # TODO: report bug:
      # nix module asserts that virtualUsers implies localUsers != null but that has a default value of false (always != null)
      userDbPath = lib.removeSuffix ".db" config.age.secrets.vsftpd-user-db.path;
      # User needs write permissions inside their chroot() jail
      allowWriteableChroot = true;
      chrootlocalUser = true;
      localRoot = paperlessConsumePath;
      virtualUseLocalPrivs = true;
      writeEnable = true;
      # SSL
      forceLocalLoginsSSL = true;
      forceLocalDataSSL = true;
      rsaKeyFile = "/var/lib/acme/${paperlessDomain}/key.pem";
      rsaCertFile = "/var/lib/acme/${paperlessDomain}/cert.pem";
      extraConfig = ''
        # Certain clients don't like the default
        ssl_ciphers=HIGH
        # Allow passive mode for some clients
        pasv_enable=YES
        pasv_min_port=${builtins.toString ftps_psv_min_port}
        pasv_max_port=${builtins.toString ftps_psv_max_port}
        # Delete only 'others' permissions
        local_umask=0007
        # Both 'vsftpd' owner and 'paperless' group need r/w
        chown_upload_mode=0660
        # Also log FTP transfers
        log_ftp_protocol=YES
        xferlog_enable=YES
      '';
    };

    paperless = {
      enable = true;
      port = 10000;
      address = "0.0.0.0";
      passwordFile = config.age.secrets.paperless-ngx-password.path;
      mediaDir = "/paperless/media";
      consumptionDir = paperlessConsumePath;
      settings = {
        PAPERLESS_URL = "https://${paperlessDomain}";
        # TODO: set before doing fresh install
        # PAPERLESS_ADMIN_USER = "";

        # Ghostscript is entirely bug-free.
        PAPERLESS_OCR_USER_ARGS = builtins.toJSON {
          continue_on_soft_render_error = true;
        };

        PAPERLESS_CONSUMER_ENABLE_BARCODES = true;
        PAPERLESS_CONSUMER_ENABLE_ASN_BARCODE = true;
        PAPERLESS_CONSUMER_BARCODE_SCANNER = "ZXING";
        PAPERLESS_CONSUMER_RECURSIVE = true;
        PAPERLESS_FILENAME_FORMAT = "{created_year}-{created_month}-{created_day}_{asn}_{title}";

        # Let nginx handle compression
        PAPERLESS_ENABLE_COMPRESSION = false;

        #PAPERLESS_IGNORE_DATES = concatStringsSep "," ignoreDates;
        PAPERLESS_NUMBER_OF_SUGGESTED_DATES = 8;
        PAPERLESS_OCR_LANGUAGE = "deu+eng";
        PAPERLESS_TASK_WORKERS = 4;
        PAPERLESS_WEBSERVER_WORKERS = 4;
      };
    };
  };
}

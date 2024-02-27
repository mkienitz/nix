{
  config,
  lib,
  pkgs,
  ...
}: let
  paperlessDomain = "paperless.maxkienitz.com";
in {
  imports = [../../../modules/nixos/acme/maxkienitz.com];

  age.secrets.smb-paperless-credentials.rekeyFile = ../secrets/smb-paperless-credentials.age;
  age.secrets.paperless-ngx-password = {
    rekeyFile = ../secrets/paperless-ngx-password.age;
    group = "paperless";
    mode = "440";
  };

  environment.systemPackages = [pkgs.cifs-utils];
  fileSystems."/paperless/consume" = {
    device = "//mimas/paperless";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
    in ["${automount_opts},vers=3.1.1,credentials=${config.age.secrets.smb-paperless-credentials.path},uid=paperless,gid=paperless"];
  };

  networking.firewall.allowedTCPPorts = [80 443];

  security.acme.certs.${paperlessDomain}.inheritDefaults = true;

  # TODO: use upstreams
  services.nginx = {
    enable = true;
    virtualHosts.${paperlessDomain} = {
      forceSSL = true;
      useACMEHost = paperlessDomain;
      extraConfig = ''
        client_max_body_size 512M;
      '';
      locations."/" = let
        inherit (config.services.paperless) address port;
      in {
        proxyPass = "http://${address}:${builtins.toString port}";
        proxyWebsockets = true;
      };
    };
  };

  systemd.services.paperless-web.script = lib.mkBefore "mkdir -p /tmp/paperless";

  services.paperless = {
    enable = true;
    port = 10000;
    address = "0.0.0.0";
    passwordFile = config.age.secrets.paperless-ngx-password.path;
    mediaDir = "/paperless/media";
    consumptionDir = "/paperless/consume";
    settings = {
      PAPERLESS_URL = "https://${paperlessDomain}";
      # PAPERLESS_ALLOWED_HOSTS = paperlessDomain;
      PAPERLESS_CORS_ALLOWED_HOSTS = "https://${paperlessDomain}";
      # PAPERLESS_TRUSTED_PROXIES = sentinelCfg.meta.wireguard.proxy-sentinel.ipv4;

      # Ghostscript is entirely bug-free.
      PAPERLESS_OCR_USER_ARGS = builtins.toJSON {
        continue_on_soft_render_error = true;
      };

      # virtiofsd doesn't send inotify events (not sure if generally, or because we
      # mount the same host share on another vm (samba) and modify it there).
      PAPERLESS_CONSUMER_POLLING = 1; # seconds
      # Wait three seconds between file-modified checks. After 5 consecutive checks
      # where the file wasn't modified it will be consumed.
      PAPERLESS_CONSUMER_POLLING_DELAY = 3;

      PAPERLESS_CONSUMER_ENABLE_BARCODES = true;
      PAPERLESS_CONSUMER_ENABLE_ASN_BARCODE = true;
      PAPERLESS_CONSUMER_BARCODE_SCANNER = "ZXING";
      PAPERLESS_CONSUMER_RECURSIVE = true;
      # PAPERLESS_FILENAME_FORMAT = "{owner_username}/{created_year}-{created_month}-{created_day}_{asn}_{title}";

      # Nginx does that better.
      PAPERLESS_ENABLE_COMPRESSION = false;

      #PAPERLESS_IGNORE_DATES = concatStringsSep "," ignoreDates;
      PAPERLESS_NUMBER_OF_SUGGESTED_DATES = 8;
      PAPERLESS_OCR_LANGUAGE = "deu+eng";
      PAPERLESS_TASK_WORKERS = 4;
      PAPERLESS_WEBSERVER_WORKERS = 4;
    };
  };
}

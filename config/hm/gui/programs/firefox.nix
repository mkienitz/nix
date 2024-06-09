{
  home.persistence."/state".directories = [
    ".cache/mozilla"
  ];
  home.persistence."/persist".directories = [
    ".mozilla"
  ];
  stylix.targets.firefox.enable = true;
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      isDefault = true;
      settings = {
        # Resume previous session
        "browser.startup.page" = 3;
        # Telemetry off
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.unified" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.urlbar.eventTelemetry.enabled" = false;
        # Other
        "extensions.pocket.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "identity.fxaccounts.toolbar.enabled" = false;
        "identity.fxaccounts.pairing.enabled" = false;
        "identity.fxaccounts.commands.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "browser.contentblocking.report.lockwise.enabled" = false;
      };
    };
  };
}

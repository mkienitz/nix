{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.bipper.nixosModules.default];
  services.postgresql = {
    enable = true;
    ensureDatabases = ["bipper"];
    identMap = ''
      # ArbitraryMapName systemUser DBUser
      superuser_map      root      postgres
      superuser_map      postgres  postgres
      # Let other names login as themselves
      superuser_map      /^(.*)$   \1
    '';
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method optional_ident_map
      local sameuser  all     peer        map=superuser_map
    '';
    ensureUsers = [
      {
        name = "bipper";
        ensurePermissions = {
          "DATABASE bipper" = "ALL PRIVILEGES";
        };
      }
    ];
  };
  services.bipper = {
    enable = true;
    address = "127.0.0.1";
    port = 3939;
  };
}
